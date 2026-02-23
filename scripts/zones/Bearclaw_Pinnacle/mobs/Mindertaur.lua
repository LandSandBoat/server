---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 6)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 55)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local eldertaur = GetMobByID(mob:getID() - 1)

    local skills =
    {
        xi.mobSkill.TRICLIP_1,
        xi.mobSkill.BACK_SWISH_1,
        xi.mobSkill.MOW_1,
        xi.mobSkill.FRIGHTFUL_ROAR_1,
        xi.mobSkill.UNBLESSED_ARMOR,
    }

    if eldertaur and not eldertaur:isAlive() then
        table.insert(skills, xi.mobSkill.CHTHONIAN_RAY)
    end

    return skills[math.random(1, #skills)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BANISH_II,  target, false, xi.action.type.DAMAGE_TARGET,    nil,               0, 100 },
        [2] = { xi.magic.spell.FLASH,      target, false, xi.action.type.DAMAGE_TARGET,    nil,               0, 100 },
        [3] = { xi.magic.spell.CURE_V,     mob,    true,  xi.action.type.HEALING_TARGET,   75,                0, 100 },
        [4] = { xi.magic.spell.PROTECT_IV, mob,    true,  xi.action.type.ENHANCING_TARGET, xi.effect.PROTECT, 0, 100 },
        [5] = { xi.magic.spell.SHELL_IV,   mob,    true,  xi.action.type.ENHANCING_TARGET, xi.effect.SHELL,   0, 100 },
    }

    local groupTable =
    {
        GetMobByID(mob:getID() - 1), -- Eldertaur
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
