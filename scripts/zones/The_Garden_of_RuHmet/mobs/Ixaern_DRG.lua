-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TMobEntity
local entity = {}

local breathList =
{
    [xi.mobSkill.WING_THRUST]       = xi.mobSkill.PET_FLAME_BREATH,
    [xi.mobSkill.AURORAL_WIND]      = xi.mobSkill.PET_GUST_BREATH,
    [xi.mobSkill.IMPACT_STREAM]     = xi.mobSkill.PET_LIGHTNING_BREATH,
    [xi.mobSkill.DEPURATION]        = xi.mobSkill.PET_HYDRO_BREATH,
    [xi.mobSkill.CRYSTALINE_COCOON] = xi.mobSkill.PET_FROST_BREATH,
    [xi.mobSkill.MEDUSA_JAVELIN]    = xi.mobSkill.PET_SAND_BREATH,
}

local function toggleBracelets(mob)
    local braceletActive = mob:getLocalVar('braceletActive')

    if braceletActive == 0 then
        mob:setLocalVar('braceletTimer', GetSystemTime() + 30)
        mob:setLocalVar('braceletActive', 1)
        mob:setAnimationSub(2)
        mob:addMod(xi.mod.ATTP, 30)
        mob:addMod(xi.mod.ACC, 40)
        mob:addMod(xi.mod.DELAYP, -33)
    elseif braceletActive == 1 then
        mob:setLocalVar('braceletTimer', GetSystemTime() + 80)
        mob:setLocalVar('braceletActive', 0)
        mob:setAnimationSub(1)
        mob:delMod(xi.mod.ACC, 40)
        mob:delMod(xi.mod.ATTP, 30)
        mob:delMod(xi.mod.DELAYP, -33)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('braceletTimer', GetSystemTime() + 80)
end

entity.onMobEngage = function(mob, target)
    -- Set repop on Wynavs to 20 seconds after engaged
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        if wynav then
            if not wynav:isSpawned() then
                wynav:setLocalVar('repop', GetSystemTime() + 20)
            elseif wynav:getCurrentAction() == xi.act.ROAMING then
                wynav:updateEnmity(target)
            end
        end
    end
end

entity.onMobFight = function(mob, target)
    -- Spawn the pets if they are despawned
    local mobId = mob:getID()
    local wynavList = {}

    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        if wynav then
            local repopWynavs = wynav:getLocalVar('repop') -- see Wynav script
            if
                not wynav:isSpawned() and
                GetSystemTime() > repopWynavs
            then
                table.insert(wynavList, i)
            end
        end
    end

    if #wynavList > 0 then
        xi.mob.callPets(mob, wynavList)
    end

    local braceletTimer = mob:getLocalVar('braceletTimer')
    if GetSystemTime() > braceletTimer then
        toggleBracelets(mob)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- When Ix'Aern DRG uses a mob skill, all his pets use a corresponding breath attack
    local mobId = mob:getID()
    local breathSkill = breathList[skill:getID()]
    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        if
            wynav and
            wynav:isSpawned() and
            wynav:getCurrentAction() == xi.act.ATTACK
        then
            wynav:useMobAbility(breathSkill)
        end
    end
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('braceletActive', 0)
    mob:setAnimationSub(1)
end

entity.onMobDeath = function(mob, player, optParams)
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        if
            wynav and
            wynav:isSpawned()
        then
            wynav:setHP(0)
        end
    end
end

entity.onMobDespawn = function(mob)
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end

    -- Pick a new PH for Ix'Aern (DRG)
    local groups = ID.mob.AWAERN_DRG_GROUPS
    SetServerVariable('[SEA]IxAernDRG_PH', groups[math.random(1, #groups)] + math.random(0, 2))
end

return entity
