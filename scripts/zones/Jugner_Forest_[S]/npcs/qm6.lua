-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: ???
-- Type: Quest NPC
-- !pos 68 -0.5 324 82
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cotgStat = player:getCharVar("ClawsOfGriffonProg")

    if cotgStat == 1 then
        player:startEvent(201)
    elseif player:getCharVar("FingerfilcherKilled") == 1 then
        player:startEvent(203)
    elseif cotgStat == 2 and not GetMobByID(ID.mob.FINGERFILCHER_DRADZAD):isSpawned() then
        player:startEvent(202)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 201 then
        player:setCharVar("ClawsOfGriffonProg", 2)
    elseif csid == 202 then
        SpawnMob(ID.mob.FINGERFILCHER_DRADZAD):updateClaim(player)
    elseif csid == 203 then
        npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON, {item=813, var={"ClawsOfGriffonProg", "FingerfilcherKilled"}})
    end
end

return entity
