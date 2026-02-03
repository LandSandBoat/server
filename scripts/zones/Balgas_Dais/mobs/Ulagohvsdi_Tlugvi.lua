-----------------------------------
-- Area: Balga's Dais
--  Mob: Ulagohvsdi Tlugvi (NIN) "Autumn Tree"
-- BCNM: Season's Greetings
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.SLOW_RES_RANK, 7)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 7)
    mob:setMod(xi.mod.BIND_RES_RANK, 7)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('mijinGakureTime', 0)
end

-- If it has been more than 2 minutes since Mijin Gakure was used, gain a significant damage boost.
entity.onMobFight = function(mob, target)
    if mob:getMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER) == 250 then
        return
    end

    local mijinGakureTime = mob:getLocalVar('mijinGakureTime')

    if
        mijinGakureTime > 0 and
        GetSystemTime() > mijinGakureTime + 120
    then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    end
end

-- Has additional effect: Paralyze (15% chance)
entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.PARALYSIS,
        power    = 20,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

-- Only uses Pinecone Bomb.
entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.PINECONE_BOMB
end

-- If Mijin Gakure is used, the Winter tree (Gola Tlugvi) attacks.
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    if skillID == xi.mobSkill.MIJIN_GAKURE_1 then
        local currentTime = GetSystemTime()
        mob:setLocalVar('mijinGakureTime', currentTime)
        local baseId = mob:getID()
        local winterTree = GetMobByID(baseId + 1)

        if winterTree and winterTree:isAlive() then
            local currentTarget = mob:getTarget()
            if not currentTarget then
                return
            end

            winterTree:updateEnmity(currentTarget)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.DOTON_NI,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 2] = { xi.magic.spell.HYOTON_NI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 3] = { xi.magic.spell.HUTON_NI,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 4] = { xi.magic.spell.KATON_NI,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 5] = { xi.magic.spell.RAITON_NI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 6] = { xi.magic.spell.SUITON_NI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 7] = { xi.magic.spell.DOKUMORI_NI,  target, false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.POISON,     0, 100 },
        [ 8] = { xi.magic.spell.KURAYAMI_NI,  target, false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.BLINDNESS,  0, 100 },
        [ 9] = { xi.magic.spell.HOJO_NI,      target, false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.SLOW,       4, 100 },
        [10] = { xi.magic.spell.JUBAKU_NI,    target, false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.PARALYSIS,  0, 100 },
        [11] = { xi.magic.spell.UTSUSEMI_NI,  mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.COPY_IMAGE, 0, 100 },
    }
    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
