-----------------------------------
-- Area: King Ranperre's Tomb
--  NPC: ??? (qm1)
-- Notes: Used to teleport down the stairs
-- !pos -81 -1 -97 190
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startOptionalCutscene(10)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Missing teleport-animation. Might be a core issue as to why it wont display.
    if csid == 10 and option == 100 then
        player:setPos(-81.5, 7.297, -127.919, 71)
    end
end

return entity
