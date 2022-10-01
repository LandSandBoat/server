-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Decurio I-III
-- Involved in Quest: A Craftsman's Work
-- !pos X:113 Y:-7 Z:-72 (106)
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar("aCraftsmanWork") == 1 then
        player:setCharVar("Decurio_I_IIIKilled", 1)
    end
end

return entity
