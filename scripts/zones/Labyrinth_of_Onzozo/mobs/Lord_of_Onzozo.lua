-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Lord of Onzozo
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMonsterMagicPrepare = function(mob, target)
    local rnd = math.random()

    if rnd < 0.4 then
        return 201 -- Waterga III
    elseif rnd < 0.7 then
        return 214 -- Flood
    elseif rnd < 0.9 then
        return 361 -- Blindga
    else
        return 172 -- Water IV
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 774, 1, xi.regime.type.GROUNDS)
end

return entity
