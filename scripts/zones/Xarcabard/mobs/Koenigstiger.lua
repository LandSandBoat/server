-----------------------------------
-- Area: Xarcabard
--  Mob: Koenigstiger
-- Involved in Quests: Unbridled Passion (RNG AF3)
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar('unbridledPassion') == 4 then
        player:setCharVar('unbridledPassion', 5)
    end
end

return entity
