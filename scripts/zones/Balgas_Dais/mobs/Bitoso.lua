-----------------------------------
-- Area: Balga's Dais
--  Mob: Bitoso
-- BCNM: Creeping Doom
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMobMod(xi.mobMod.HEAL_CHANCE, 100)
    mob:setMod(xi.mod.REGEN, 0)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 13)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { spellId = xi.magic.spell.CURE_III },
        [2] = { spellId = xi.magic.spell.PARALYGA },
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, nil, nil)
end

return entity
