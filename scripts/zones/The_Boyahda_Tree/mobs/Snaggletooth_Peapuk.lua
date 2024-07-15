-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Snaggletooth Peapuk
-----------------------------------
mixins = { require('scripts/mixins/families/puk') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1724 then
        mob:setLocalVar('UsedWhiteWind', 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 726, 2, xi.regime.type.GROUNDS)
end

return entity
