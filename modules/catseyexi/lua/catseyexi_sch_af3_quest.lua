-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("modules/module_utils")
-----------------------------------

local m = Module:new("catseyexi_sch_af3_quest")

-----------------------------------
-- Area: Pashhow Marshlands [S]
-----------------------------------

m:addOverride("xi.zones.Pashhow_Marshlands_[S].Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Pashhow_Marshlands_[S]/IDs")

    super(zone)

	local sch_afhat = zone:insertDynamicEntity({ 
        objtype = xi.objType.NPC,
        name = "SCH AF hat",
        look = 2331,
        x = -454.225,
        y = 25.000,
        z = -362.404,
        rotation = 0,
        widescan = 1, 

    onTrade = function(player, npc, trade)
    end,

    onTrigger = function(player, npc)
		
        if player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_BLOOD_RED) and not player:hasKeyItem(xi.ki.UNADDRESSED_SEALED_LETTER) then
            npcUtil.giveKeyItem(player, xi.ki.UNADDRESSED_SEALED_LETTER)
            player:setCharVar("[SCH]afstatus", 2)
        end
    end,})
	
	utils.unused(sch_afhat)
end)

---------------------------------------------
--         THE ELDIEME NECROPOLIS S        --
---------------------------------------------
m:addOverride("xi.zones.The_Eldieme_Necropolis_[S].Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
     --Call the zone's original function for onInitialize
    super(zone)

local sch_af3 = zone:insertDynamicEntity({ -- Sch af3 fix
        objtype = xi.objType.NPC,
        name = "SCH AF3",
        look = 2331,
        x = 377.124,
        y = -40.000,
        z = 19.466,
        rotation = 0,
        widescan = 1, 

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
		
        local schafquest = player:getCharVar("[SCH]afstatus")
		
        if player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX) and schafquest < 1 
		    then
                player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_BLOOD_RED)		
                player:PrintToPlayer("Bring me the key item Unaddressed sealed letter to receive the item you seek", 0xD)
                player:setCharVar("[SCH]afstatus", 1)
		        return	
	        elseif player:getCharVar("[SCH]afstatus") == 2 and player:hasKeyItem(xi.ki.UNADDRESSED_SEALED_LETTER) then
		        player:addItem(16140)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 16140)
                player:delKeyItem(xi.ki.UNADDRESSED_SEALED_LETTER)
                player:setCharVar("[SCH]afstatus", 3)	
                player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX)			
		    end
		end,
    })

    utils.unused(sch_af3)

end)

return m
