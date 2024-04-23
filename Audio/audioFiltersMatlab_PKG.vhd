LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


package audioFiltersMatlab_PKG is

component kj_clock_generator   --generates a 12.288MHz clock for the 
	port (
		refclk   : in  std_logic; --  refclk.clk
		rst      : in  std_logic; --   reset.reset
		outclk_0 : out std_logic);         -- outclk0.clk);
	end component;

COMPONENT audio_and_video_config
	PORT( CLOCK_50, reset : IN    STD_LOGIC;
			I2C_SDAT        : INOUT STD_LOGIC;
			I2C_SCLK        : OUT   STD_LOGIC);
END COMPONENT; 	
	
COMPONENT audio_codec
	PORT( CLOCK_50, reset, read_s, write_s               : IN  STD_LOGIC;
			writedata_left, writedata_right                : IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
			AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK : IN  STD_LOGIC;
			read_ready, write_ready                        : OUT STD_LOGIC;
			readdata_left, readdata_right                  : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
			AUD_DACDAT                                     : OUT STD_LOGIC);
END COMPONENT;	

COMPONENT filter
	PORT
	(
		clk		      :	 IN STD_LOGIC;
		clk_enable		:	 IN STD_LOGIC;
		reset		      :	 IN STD_LOGIC;
		filter_in		:	 IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		filter_out		:	 OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;
	

end audioFiltersMatlab_PKG;
