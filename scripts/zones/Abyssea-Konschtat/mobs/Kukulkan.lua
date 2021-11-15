-----------------------------------
-- Area: Abyssea - Konschtat (15)
--   NM: Kukulkan
-----------------------------------
require("scripts/globals/title")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
end

entity.onSpellPrecast = function(mob, spell)
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.KUKULKAN_DEFANGER)
end

return entity
