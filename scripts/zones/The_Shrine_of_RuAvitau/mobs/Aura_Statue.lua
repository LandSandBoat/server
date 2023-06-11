-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Aura Statue
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
if
    xi and
    xi.zones and
    xi.zones.The_Shrine_of_RuAvitau and
    xi.zones.The_Shrine_of_RuAvitau.mobs and
    xi.zones.The_Shrine_of_RuAvitau.mobs.Aura_Statue
then
    return xi.zones.The_Shrine_of_RuAvitau.mobs.Aura_Statue
else
    local entity = {}

    entity.onMobDeath = function(mob, player, optParams)
        xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
        xi.regime.checkRegime(player, mob, 754, 1, xi.regime.type.GROUNDS)
    end

    return entity
end
