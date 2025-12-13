-----------------------------------
-- Area: Throne Room
--  Mob: Demons Elemental (Thunder Elemental)
-- BCNM: Kindred Spirits
-- Job : Black Mage / Warrior
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.THUNDER_II,
        xi.magic.spell.THUNDAGA,
    }

    if not mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) then
        table.insert(spellList, xi.magic.spell.SHOCK_SPIKES)
    end

    if not mob:hasStatusEffect(xi.effect.ENTHUNDER) then
        table.insert(spellList, xi.magic.spell.ENTHUNDER)
    end

    if not target:hasStatusEffect(xi.effect.SHOCK) then
        table.insert(spellList, xi.magic.spell.SHOCK)
    end

    if not target:hasStatusEffect(xi.effect.STUN) then
        table.insert(spellList, xi.magic.spell.STUN)
    end

    return spellList[math.random(1, #spellList)]
end

return entity
