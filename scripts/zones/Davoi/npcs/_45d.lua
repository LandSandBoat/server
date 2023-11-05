-----------------------------------
-- Area: Davoi
--  NPC: Wall of Banishing
-- Used In Quest: Whence Blows the Wind
-- !pos 181 0.1 -218 149
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        if player:hasKeyItem(xi.ki.CRIMSON_ORB) then
            player:startEvent(42)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 42 and option == 0 then
        player:messageSpecial(ID.text.POWER_OF_THE_ORB_ALLOW_PASS)

        -- Animation for the "door" being open.
        -- NOTE: npc:openDoor sends a different animation packet and doesn't work.
        npc:setAnimation(8)
        npc:timer(1000 * 20, function(npcArg)
            npcArg:setAnimation(9)
        end)
    end
end

return entity
