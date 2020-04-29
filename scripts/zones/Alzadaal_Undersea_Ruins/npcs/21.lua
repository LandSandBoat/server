-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: 21 (no name)
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local transformationsProgress = player:getCharVar("TransformationsProgress")
    -- TRANSFORMATIONS
    if transformationsProgress >= 2 and transformationsProgress <= 4 and not GetMobByID(ID.mob.NEPIONIC_SOULFLAYER):isSpawned() then
        player:startEvent(4)
    elseif player:getCharVar("TransformationsProgress") == 5 then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 4 then
        SpawnMob(ID.mob.NEPIONIC_SOULFLAYER)
    elseif csid == 5 then
        npcUtil.completeQuest(player, AHT_URHGAN, TRANSFORMATIONS, {
            item = 15265,
            title = tpz.title.PARAGON_OF_BLUE_MAGE_EXCELLENCE,
            var = {"TransformationsProgress"}
        })
    end
end