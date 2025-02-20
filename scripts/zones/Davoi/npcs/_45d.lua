-----------------------------------
-- Area: Davoi
--  NPC: Wall of Banishing
-- Used In Quest: Whence Blows the Wind
-- !pos 181 0.1 -218 149
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.animation.CLOSE_DOOR then
        if player:hasKeyItem(xi.ki.CRIMSON_ORB) then
            player:startEvent(42)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 42 and
        option == 0 and
        npc:getAnimation() == xi.animation.CLOSE_DOOR
    then
        player:messageSpecial(ID.text.POWER_OF_THE_ORB_ALLOW_PASS)

        -- NOTE: npc:openDoor sends a different animation packet and doesn't work.
        -- TODO: Decide what to do with openDoor(). Replace this with it if we do change it.

        -- Animation for the "door" being open.
        npc:setAnimation(xi.animation.OPEN_DOOR)

        -- Close door after 20 seconds.
        npc:timer(20000, function(npcArg)
            npcArg:setAnimation(xi.animation.CLOSE_DOOR)
        end)
    end
end

return entity
