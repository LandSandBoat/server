-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Heavy Metal Crab
-- BCNM: Crustacean Conundrum
-- TODO: Cap each hit by 1, not the total damage of an attack. i.e multihits.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.RECEIVED_DAMAGE_CAP, 1)
    mob:setMod(xi.mod.RECEIVED_DAMAGE_VARIANT, 1)
end

entity.onMobFight = function(mob, target)
    if mob:getMod(xi.mod.REGEN_DOWN) ~= 0 then -- Crabs can recieve DOTs, but they do not deal damage.
        mob:setMod(xi.mod.REGEN_DOWN, 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 20,
        animation      = xi.subEffect.HP_DRAIN,
        basePower      = 30, -- Always deals 30.
        drainHP        = true,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobMobskillChoose = function(mob, target, mobSkillID)
    local skillList =
    {
        xi.mobSkill.BUBBLE_SHOWER_1,
        xi.mobSkill.BUBBLE_CURTAIN_1,
        xi.mobSkill.BIG_SCISSORS_1,
        xi.mobSkill.SCISSOR_GUARD_1,
    }

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.WATERGA,
        xi.magic.spell.BIO,
        xi.magic.spell.BLIND,
    }

    return spellList[math.randomInt(1, #spellList)]
end

return entity
