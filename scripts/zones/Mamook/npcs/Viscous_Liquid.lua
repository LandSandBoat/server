-----------------------------------
-- Area: Mamook
-- NPC: Viscous Liquid
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(214)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 214 and
        option == 1
    then
        -- Wait 100ms for client to realize it's been unlocked from a CS
        -- some kind of strange timing/race condition with interactions
        -- TODO: fix in core?
        player:timer(100, function(playerArg)
            playerArg:addStatusEffect(xi.effect.ILLUSION, 1600, 0,  900, 0, 28)
        end)

        player:messageText(player, ID.text.PECULIAR_SENSATION)
    end
end

return entity
