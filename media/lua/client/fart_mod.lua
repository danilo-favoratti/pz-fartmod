TNTMod = TNTMod

local function TNT_Fart ()
	local activePlayersNum = getNumActivePlayers() -1
	for playerIndex = 0, activePlayersNum  do
	 	local player = getSpecificPlayer(playerIndex)
	 	 player:playSound("Fart1")
	end
end

Events.EveryTenMinutes.Add(TNT_Fart)