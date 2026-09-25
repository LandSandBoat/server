-----------------------------------
-- Area: Jugner Forest
--   NM: King Arthro
-----------------------------------
mixins =
{
    require('scripts/mixins/rage')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    local respawnTime = 900 + math.randomInt(0, 6) * 1800 -- 0:15 to 3:15 spawn timer in 30 minute intervals
    for offset = 1, 10 do
        GetMobByID(mob:getID() - offset):setRespawnTime(respawnTime)
    end

    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.POISON)

    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.UFASTCAST, 90)

    mob:setMobMod(xi.mobMod.GIL_MIN, 10000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 10000)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(60, 65))
    mob:setLocalVar('[2hour]Used', 0)

    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)

    mob:setMod(xi.mod.DEF, 500)
    local kingArthroID = mob:getID()

    -- Use King Arthro ID to determine Knight Crab Id's, then set their respawn to 0 so they don't spawn while KA is up
    for offset = 1, 10 do
        GetMobByID(kingArthroID - offset):setRespawnTime(0)
    end
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if mob:getLocalVar('[2hour]Used') ~= 0 then
        return
    end

    if mob:getHPP() >= mob:getLocalVar('[2hour]HPP') then
        return
    end

    mob:setLocalVar('[2hour]Used', 1)
    mob:useMobAbility(xi.mobSkill.HUNDRED_FISTS_1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.WATERGA_IV,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 200 },
        [2] = { xi.magic.spell.ENWATER,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ENWATER,   1, 100 },
        [3] = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,     1, 100 },
        [4] = { xi.magic.spell.POISONGA_II, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,    2, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.PARALYSIS,
        power    = 75,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDespawn = function(mob)
    local kingArthroID = mob:getID()

    GetMobByID(kingArthroID):setLocalVar('[POP]King_Arthro', 0)

    -- Set respawn of 21:05 to 24:05
    local respawnTime = 75900 + math.randomInt(0, 6) * 1800 -- 21:05 to 24:05 respawn timer in 30 minute intervals
    for offset = 1, 10 do
        GetMobByID(kingArthroID - offset):setRespawnTime(respawnTime)
    end
end

return entity
