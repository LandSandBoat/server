-----------------------------------
-- func: !npc
-- desc: Test dynamic entity before its placed into a module for testing.
-- note: Will spawn after you move from your current position
-----------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    super(zone)

    local Fixme = zone:insertDynamicEntity({
    objtype = xi.objType.NPC,
    name = "Fixme",
    look = 2100,
    x = 11.360,
    y = 3.100,
    z = 116.881,
    rotation = 128,
    widescan = 1,

	onTrade = function(playerArg, npcArg, trade)
    end,

    onTrigger = function(playerArg, npcArg)
	    if playerArg:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.COP.CHAINS_AND_BONDS then
		    playerArg:PrintToPlayer("Busted mission detected. Skipping ...")
			playerArg:completeMission(xi.mission.log_id.COP, xi.mission.id.COP.CHAINS_AND_BONDS)
			playerArg:setMissionStatus(xi.mission.log_id.COP, 0)
			playerArg:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)
			playerArg:PrintToPlayer("Fixme: You should now be on \"Flames in the Darkness\".", 0xD)
		else
		    playerArg:PrintToPlayer("Fixme: Get out of here!", 0xD)
		end	
    end,

    })

end