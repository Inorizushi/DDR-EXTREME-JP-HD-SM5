return Def.ActorFrame{
	Def.Actor{
		OnCommand=function(s)
			s:sleep(1.8)
		end
	};

	Def.Sound{
	File=THEME:GetPathS("","_moreswoosh"),
	StartTransitioningCommand=function(s)
		s:play()
	end,
	},

	Def.Sprite{
		Texture=THEME:GetPathB("","_moveon"),
		InitCommand=function(s)
			s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-10):zoomy(0):diffusealpha(0)
		end,
		OnCommand=function(s)
			s:diffusealpha(0):zoomy(0):sleep(0.916):linear(0.233):diffusealpha(1):zoomy(1)
		end,
	};
};