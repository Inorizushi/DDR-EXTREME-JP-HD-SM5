local FL = true
return Def.ActorFrame{
	InitCommand=cmd(xy,_screen.cx-174,_screen.cy-66);
	OnCommand=cmd(addx,(-SCREEN_WIDTH/2.28);sleep,0.450;linear,0.267;addx,(SCREEN_WIDTH/2.33);linear,0.05;addx,-6;decelerate,0.116;addx,12;decelerate,0.067;addx,-4;decelerate,0.1;addx,4);
	OffCommand=cmd(accelerate,0.316;addx,(-SCREEN_WIDTH/2.28));
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	--Group/Song Fading Banner
	Def.FadingBanner{
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
			local so = GAMESTATE:GetSortOrder()
			if song then
				self:LoadFromSong(song)
				self:scaletoclipped(256,80)
				FL = false
			elseif not FL then
				FL = true
				if so == "SortOrder_Group" then
					self:LoadFromSortOrder('SortOrder_Length')
				else
					self:LoadFromSortOrder(so)
				end;
			end
		end;
	};
	--Roulette Banner
	Def.FadingBanner{
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
			FL = false
			if song then
				FL = false
				self:visible(false)
			elseif not FL then
				FL = true
				if mw:GetSelectedType() == 'WheelItemDataType_Roulette' then
					self:LoadRoulette()
					self:visible(true)
					FL = false
				else
					self:visible(false)
				end;
			end
		end;
	};
	--Random Banner
	Def.FadingBanner{
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
			FL = false
			if song then
				FL = false
				self:visible(false)
			elseif not FL then
				FL = true
				if mw:GetSelectedType() == 'WheelItemDataType_Random' then
					self:LoadRandom()
					self:visible(true)
					FL = false
				else
					self:visible(false)
				end;
			end
		end;
	};
	--Cached Banner fix
	Def.Sprite{
		OnCommand=cmd(playcommand,"Set"),
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			if song then
				self:finishtweening():diffusealpha(0):Load(song:GetBannerPath())
				self:sleep(0.4):linear(0.1):diffusealpha(1)
			elseif course then
				self:y(2)
				local actualpath = string.gsub(course:GetCourseDir(), ".crs", "")
				if FILEMAN:DoesFileExist(actualpath..".png") then
					self:Load(actualpath..".png")
				else
					self:Load(THEME:GetPathG("","Common fallback banner"))
				end
			else
				self:diffusealpha(0)
			end;
			self:scaletoclipped(256,80);
		end;
	};
};
