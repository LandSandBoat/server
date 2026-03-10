-----------------------------------
-- Area: Spire of Vahzl
--   NM: Memory Receptacle (Shield)
-- Note: Three color variants: Teal = Melee, Green = Magic, Blue = Ranged.
-- When one of them dies, it removes its respective damage immunity from the main receptacle
-- Summons a respective Promyvion NM mob type on death
-----------------------------------
local ID = zones[xi.zone.SPIRE_OF_VAHZL]
-----------------------------------
---@type TMobEntity
local entity = {}

local shieldData =
{
    [0] = { modelId = 1102, immunities = { xi.mod.UDMGPHYS } },                     -- Teal
    [1] = { modelId = 1103, immunities = { xi.mod.UDMGMAGIC, xi.mod.UDMGBREATH } }, -- Green
    [2] = { modelId = 1104, immunities = { xi.mod.UDMGRANGE } },                    -- Blue
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.POISON)
end

entity.onMobSpawn = function(mob)
    local offset = (mob:getBattlefield():getArea() - 1) * 10
    local index  = mob:getID() - ID.mob.MEMORY_RECEPTACLE_SHIELD - offset
    mob:setModelId(shieldData[index].modelId)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setBaseSpeed(40)

    -- Undo family wide SDT resistances
    mob:setMod(xi.mod.SLASH_SDT, 0)
    mob:setMod(xi.mod.PIERCE_SDT, 0)
    mob:setMod(xi.mod.HTH_SDT, 0)
    mob:setMod(xi.mod.IMPACT_SDT, 0)
end

entity.onMobFight = function(mob, target)
    if mob:isFollowingPath() then
        return
    end

    -- Apply no move after pathing completes
    if mob:getLocalVar('wasPathing') == 1 then
        mob:setLocalVar('wasPathing', 0)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end

    -- Use empty seed if flagged to do so by the main receptacle
    if
        mob:getLocalVar('useEmptySeed') == 1 and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:setLocalVar('useEmptySeed', 0)
        mob:useMobAbility(xi.mobSkill.EMPTY_SEED, target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local offset = (mob:getBattlefield():getArea() - 1) * 10
        local index  = mob:getID() - ID.mob.MEMORY_RECEPTACLE_SHIELD - offset

        -- Remove this shield's damage immunity from the Red Receptacle
        local redMob = GetMobByID(ID.mob.MEMORY_RECEPTACLE_RED + offset)
        if redMob then
            for _, immunity in ipairs(shieldData[index].immunities) do
                redMob:setMod(immunity, 0)
            end
        end

        -- Spawn the corresponding Promyvion Mob (Contemplator/Ingurgitator/Repiner)
        local nmMob = GetMobByID(mob:getID() + 3)
        if nmMob and not nmMob:isSpawned() then
            local pos = mob:getPos()
            nmMob:setSpawn(pos.x, pos.y, pos.z, pos.rot)
            nmMob:spawn()
            nmMob:updateEnmity(player)
        end
    end
end

return entity
