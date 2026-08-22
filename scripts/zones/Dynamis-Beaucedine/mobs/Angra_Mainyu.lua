-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Angra Mainyu
-- Note: Mega Boss
-----------------------------------
---@type TMobEntity
local entity = {}

local teleportThresholds =
{
    [1] = 90,
    [2] = 80,
    [3] = 70,
    [4] = 60,
    [5] = 50,
    [6] = 40,
    [7] = 30,
    [8] = -1,
}

local teleportPositions =
{
    { x = 304.000, y = 20.000, z = 424.000 },
    { x = 251.150, y = 20.356, z = 441.737 },
    { x = 365.364, y = 20.688, z = 423.416 },
    { x = 361.915, y = 20.000, z = 483.319 },
    { x = 214.977, y = 20.694, z = 516.304 },
}

entity.onMobInitialize = function(mob)
    mob:setSpawnAnimation(1)

    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)

    mob:addListener('MAGIC_STATE_EXIT', 'ANGRA_MAINYU_GRAVIGA', function(mobArg, spell)
        if spell:getID() == xi.magic.spell.GRAVIGA then
            mobArg:useMobAbility(xi.mobSkill.PET_CHARM)
        end
    end)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'ANGRA_MAINYU_TELEPORT', function(mobArg, skillId, wasExecuted)
        if skillId == xi.mobSkill.PET_CHARM and wasExecuted then
            local position = teleportPositions[math.randomInt(1, #teleportPositions)]
            mobArg:useMobAbility(xi.mobSkill.WHISTLE_CALL)
            mobArg:setPos(position.x, position.y, position.z)
        end
    end)
end

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)

    mob:setMod(xi.mod.SPELLINTERRUPT, 100)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)

    mob:setLocalVar('[2hour]Used', 0)
    mob:setLocalVar('TeleportIndex', 1)
end

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        local mobAdd = GetMobByID(i)
        if mobAdd and not mobAdd:isSpawned() then
            SpawnMob(i)
        end
    end
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local hpPercent     = mob:getHPP()
    local teleportIndex = mob:getLocalVar('TeleportIndex')

    if hpPercent <= teleportThresholds[teleportIndex] then
        mob:castSpell(xi.magic.spell.GRAVIGA, target)
        mob:setLocalVar('TeleportIndex', teleportIndex + 1)
        return
    end

    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        local pet = GetMobByID(i)
        if
            pet and
            pet:isSpawned() and
            pet:getCurrentAction() == xi.action.category.ROAMING
        then
            pet:updateEnmity(target)
        end
    end

    -- 2 Hour.
    if hpPercent > 25 then
        return
    end

    if mob:getLocalVar('[2hour]Used') == 1 then
        return
    end

    mob:useMobAbility(xi.mobSkill.CHAINSPELL_1)
    mob:setLocalVar('[2hour]Used', 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local hpPercent = mob:getHPP()
    if hpPercent <= 25 then
        return xi.magic.spell.DEATH
    elseif hpPercent <= 50 then
        return xi.magic.spell.DRAIN
    end

    local spellList =
    {
        xi.magic.spell.BLINDGA,
        xi.magic.spell.SLOWGA,
        xi.magic.spell.DISPELGA,
        xi.magic.spell.SLEEPGA_II,
        xi.magic.spell.SILENCEGA,
    }

    return spellList[math.randomInt(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
end

return entity
