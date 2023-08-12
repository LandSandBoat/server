-----------------------------------
-- Area: Arrapago Reef
-- Door: Iron Gate (Lamian Fang Key)
-- !pos 580 -17 120
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        if npcUtil.tradeHas(trade, xi.items.LAMIAN_FANG_KEY) then
            npc:openDoor()
            player:messageSpecial(ID.text.KEY_BREAKS, xi.items.LAMIAN_FANG_KEY)
            player:confirmTrade()
        elseif
            npcUtil.tradeHas(trade, xi.items.SET_OF_THIEFS_TOOLS) and
            player:getMainJob() == xi.job.THF
        then
            if math.random(1, 2) == 1 then -- TODO: figure out actual percentage chance to pick locks; 50% for now
                player:messageSpecial(ID.text.LOCK_SUCCESS, xi.items.SET_OF_THIEFS_TOOLS)
                npc:openDoor()
            else
                player:messageSpecial(ID.text.LOCK_FAIL, xi.items.SET_OF_THIEFS_TOOLS)
            end

            player:confirmTrade()
        elseif
            npcUtil.tradeHas(trade, xi.items.LIVING_KEY) and
            player:getMainJob() == xi.job.THF
        then
            if math.random(1, 2) == 1 then -- TODO: figure out actual percentage chance to pick locks; 50% for now
                player:messageSpecial(ID.text.LOCK_SUCCESS, xi.items.LIVING_KEY)
                npc:openDoor()
            else
                player:messageSpecial(ID.text.LOCK_FAIL, xi.items.LIVING_KEY)
            end

            player:confirmTrade()
        elseif
            npcUtil.tradeHas(trade, xi.items.SKELETON_KEY) and
            player:getMainJob() == xi.job.THF
        then
            if math.random(1, 2) == 1 then -- TODO: figure out actual percentage chance to pick locks; 50% for now
                player:messageSpecial(ID.text.LOCK_SUCCESS, xi.items.SKELETON_KEY)
                npc:openDoor()
            else
                player:messageSpecial(ID.text.LOCK_FAIL, xi.items.SKELETON_KEY)
            end

            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 120 and npc:getAnimation() == xi.anim.CLOSE_DOOR then
        if player:getMainJob() == xi.job.THF then
            player:messageSpecial(ID.text.DOOR_IS_LOCKED2, xi.items.LAMIAN_FANG_KEY, xi.items.SET_OF_THIEFS_TOOLS) -- message only THF's get
        else
            player:messageSpecial(ID.text.DOOR_IS_LOCKED, xi.items.LAMIAN_FANG_KEY)
        end
    elseif player:getZPos() >= 120 and npc:getAnimation() == xi.anim.CLOSE_DOOR then
        player:messageSpecial(ID.text.YOU_UNLOCK_DOOR) -- message from "inside" of door
        npc:openDoor()
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
