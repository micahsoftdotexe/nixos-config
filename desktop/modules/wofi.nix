{ config, lib, pkgs, modulesPath, nur, inputs, ... }:
{
  programs.wofi = {
    enable = true;
			style = ''
				@define-color clear rgba(0, 0, 0, 0.0);
				@define-color primary rgba(0, 0, 0, 0.75);

				window {
						margin: 2px;
						border: 0px solid;
						background-color: #${config.colorScheme.colors.base00};
						border-radius: 8px;
				}

				#input {
						padding: 4px;
						margin: 4px;
						border: none;
						background-color: #${config.colorScheme.colors.base09};
						outline: none;
				}

				#inner-box {
						margin: 4px;
						border: 0px solid;
						background-color: @clear;
						border-radius: 8px;
				}

				#outer-box {
						margin: 9px;
						border: none;
						border-radius: 8px;
						background-color: @clear;
				}

				#scroll {
						margin-bottom: 5px;
						margin: 0px;
						border: none;
				}

				#text:selected {
						color: #${config.colorScheme.colors.base05};
						margin: 0px 0px;
						border: none;
						border-radius: 8px;
				}

				#entry {
						margin: 0px 0px;
						border: none;
						border-radius: 0px;
						/* background-color: transparent;*/
				}

				#entry:selected {
						margin: 0px 0px;
						border: none;
						border-radius: 8px;
					  background-color: #${config.colorScheme.colors.base0D};
				}
			'';
  };
}