LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.audioFiltersMatlab_PKG.all;

ENTITY audioTop IS
   PORT ( 
			 CLOCK_50, CLOCK2_50, AUD_DACLRCK   : IN    STD_LOGIC;
          AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT  : IN    STD_LOGIC;
          KEY                                : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);  --DE1-SoC pushbuttons
          FPGA_I2C_SDAT                      : INOUT STD_LOGIC;
          FPGA_I2C_SCLK, AUD_DACDAT				: out std_logic;
			 AUD_XCK									   : INOUT   STD_LOGIC);
END audioTop;

ARCHITECTURE rtl OF audioTop IS
	
	

   --signals for the audio codec component
	SIGNAL read_ready, write_ready, read_s, write_s : STD_LOGIC;
   SIGNAL readdata_left, readdata_right            : STD_LOGIC_VECTOR(23 DOWNTO 0);
   SIGNAL writedata_left, writedata_right          : STD_LOGIC_VECTOR(23 DOWNTO 0);   
   SIGNAL reset                                    : STD_LOGIC;
	
	--signals for the audio processing
	signal sampleInLeft, sampleInRight : std_logic_vector(23 downto 0);
	signal sampleOutLeft, sampleOutRight : std_logic_vector(23 downto 0);
	
	
BEGIN

   reset <= NOT(KEY(0));
	
---------------------------------------------------------------------------------------------------------------------------------
-------------This block of code is necessary to communicate with the audio codec ------------------------------------------------
-------------Samples will be updated as they arrive in signals sampleInLeft and sampleInRight -----------------------------------
-------------Samples can be sent back to the audio codec DAC and audio output on signals writedata_left and writedata_right------
---------------------------------------------------------------------------------------------------------------------------------
	
 --instantiate clock generator for the Wolfson WM8731 audio codec (Generated using Altera PLL IP block)
   my_clock_gen: kj_clock_generator PORT MAP (CLOCK2_50, reset, AUD_XCK);
	
--instantiate the audio/video configuration component (Altera IP) 
	cfg: audio_and_video_config PORT MAP (CLOCK_50, reset, FPGA_I2C_SDAT, FPGA_I2C_SCLK);
	
 --instantiate the audio codec component that interacts with the Wolfson WM8731 audio codec (Altera IP)
  codec: audio_codec PORT MAP (CLOCK_50, reset, read_s, write_s, writedata_left, 
	                             writedata_right, AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK,
										  AUD_DACLRCK, read_ready, write_ready, readdata_left, 
										  readdata_right, AUD_DACDAT);
										  							  
--read_s and write_s trigger read and write operations repspectively from the audio codec component
	read_s <= read_ready and write_ready;
	write_s <= write_ready and read_ready;
	
	
--current samples updated at the sample rate (default setup is 48kHz)
	sampleInLeft  <= readdata_left;
	sampleInRight <= readdata_right;	
----------------------------------------------------------------------------------------------------------------------------------

--update output samples
   writedata_left  <= sampleInLeft;
	writedata_right <= sampleInRight;
						  
END rtl;
