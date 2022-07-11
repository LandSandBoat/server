-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Love
-- !pos 431.522 -0.912 -603.503 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local minionGroup =
{
    [0] = 10, -- Qnxzomit
    [1] = 19, -- Qnhpemde
    [2] =  1, -- Ruphuabo
    [3] = 13, -- Qnxzomit
    [4] = 22, -- Qnhpemde
    [5] =  4, -- Ruphuabo
    [6] = 16, -- Qnxzomit
    [7] = 25, -- Qnhpemde
}

local spellLists =
{
    [459] = 494, -- Fire List
    [460] = 495, -- Ice List
    [461] = 496, -- Wind List
    [462] = 497, -- Earth List
    [463] = 498, -- Ltng List
    [464] = 499, -- Water List
    [465] = 493, -- Light List
    [466] = 500, -- Dark List
}

local astralFlowPets = function()
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 27 do
        local pet = GetMobByID(i)
        if pet and pet:isAlive() then
            pet:timer(1500, function(petArg)
                if petArg:getFamily() == 269 then -- xzomit
                    petArg:useMobAbility(786) -- lateral slash
                elseif petArg:getFamily() == 144 then -- hpemde
                    petArg:useMobAbility(1367) -- sinuate rush
                elseif petArg:getFamily() == 194 then -- shark
                    petArg:useMobAbility(1353) -- aerial collision
                end
            end)
        end
    end
end

local spawnPets = function(mob, minionOffset)
    mob:entityAnimationPacket("casm")
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:timer(3000, function(mobArg)
        if mobArg:isAlive() then
            mobArg:entityAnimationPacket("shsm")
            mobArg:SetAutoAttackEnabled(true)
            mobArg:SetMagicCastingEnabled(true)
            mobArg:SetMobAbilityEnabled(true)
            GetMobByID(minionOffset + 0):setSpawn(mobArg:getXPos() + 4, mobArg:getYPos(), mobArg:getZPos())
            GetMobByID(minionOffset + 1):setSpawn(mobArg:getXPos(), mobArg:getYPos(), mobArg:getZPos() + 4)
            GetMobByID(minionOffset + 2):setSpawn(mobArg:getXPos(), mobArg:getYPos(), mobArg:getZPos() - 4)
            SpawnMob(minionOffset + 0):setMobMod(xi.mobMod.SUPERLINK, mobArg:getTargID())
            SpawnMob(minionOffset + 1):setMobMod(xi.mobMod.SUPERLINK, mobArg:getTargID())
            SpawnMob(minionOffset + 2):setMobMod(xi.mobMod.SUPERLINK, mobArg:getTargID())
            GetMobByID(minionOffset + 0):updateEnmity(mobArg:getTarget())
            GetMobByID(minionOffset + 1):updateEnmity(mobArg:getTarget())
            GetMobByID(minionOffset + 2):updateEnmity(mobArg:getTarget())
        end
    end)
end

local spawnSharks = function(mob)
    -- determine which sharks are currently spawned
    local phuaboUp = {}
    local phuaboDn = {}
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 9 do
        local phuabo = GetMobByID(i)
        if phuabo:isAlive() then
            table.insert(phuaboUp, i)
        elseif not phuabo:isSpawned() then
            table.insert(phuaboDn, i)
        end
    end
    -- how many sharks spawn depends on number currently alive
    -- https://www.bg-wiki.com/bg/Jailer_of_Love
    local numToSpawn = 0
    if #phuaboUp == 2 then
        numToSpawn = 1
    elseif #phuaboUp == 0 or #phuaboUp == 3 then
        numToSpawn = 3
    elseif #phuaboUp == 1 then
        numToSpawn = math.random(3)
    end
    -- spawn sharks
    for i = 1, math.min(numToSpawn, #phuaboDn) do
        -- spawnSharks(mob, phuaboDn)
        local target = mob:getTarget()
        GetMobByID(phuaboDn[i]):setSpawn(target:getXPos() + math.random(-2, 2), target:getYPos(), target:getZPos())
        GetMobByID(phuaboDn[i]):updateEnmity(mob:getTarget())
    end
end

entity.onMobInitialize = function(mob)
    mob:setBehaviour(2)
    mob:SetMagicCastingEnabled(true)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGEN, 260)
    mob:setMod(xi.mod.DMGMAGIC, -50) -- starts the fight with -50% magic damage taken, reduced to 25% after regen is taken off.
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.ASTRAL_FLOW, hpp = math.random(45, 55)},
        },
    })
end

entity.onMobEngaged = function(mob, target)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setAnimationSub(2)
    mob:setLocalVar("elementAbsorb", os.time() + 120)
    mob:setLocalVar("pop_pets", os.time() + 150) -- wait 2.5 minutes until spawning initial mobs
    mob:setLocalVar("currentAbsorb", math.random(459, 466)) -- pick a random element to absorb after engaging
    mob:setSpellList(spellLists[mob:getLocalVar('currentAbsorb')])
    mob:setMod(mob:getLocalVar('currentAbsorb'), 100)
end

entity.onMobFight = function(mob, target)
    -- reduce regen after nine Xzomits and Hpemdes (total of both) groups are killed
    if
        mob:getLocalVar("JoL_Regen_Reduction") == 0 and
        mob:getLocalVar("JoL_Qn_xzomit_Killed") >= 9 and
        mob:getLocalVar("JoL_Qn_hpemde_Killed") >= 9
    then
        mob:setLocalVar("JoL_Regen_Reduction", 1)
        mob:delMod(xi.mod.REGEN, 260)
        mob:setMod(xi.mod.DMGMAGIC, -25) -- magic damage taken reduced from 50% to 25% after killing nine xzomits and hpemdes
    end

    -- every 2 minutes JoL will change the element it absorbs/casts spells this change happens after a two hour animation
    if os.time() > mob:getLocalVar("elementAbsorb") then
        local abilities = { 307, 404, 603, 604, 624, 625, 626, 627 }
        local previousAbsorb = mob:getLocalVar("currentAbsorb")
        mob:setLocalVar("currentAbsorb", math.random(459, 466))
        mob:setLocalVar("elementAbsorb", os.time() + 120)
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(abilities[math.random(#abilities)])
        mob:setSpellList(spellLists[mob:getLocalVar('currentAbsorb')])

        -- remove previous absorb mod, if set
        if previousAbsorb > 0 then
            mob:setMod(previousAbsorb, 0)
        end

        -- add new absorb mod
        mob:setLocalVar("currentAbsorb", mob:getLocalVar("currentAbsorb"))
        mob:setMod(mob:getLocalVar("currentAbsorb"), 100)
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end

    -- spawn minions in 2.5 minute intervals
    if
        os.time() > mob:getLocalVar("pop_pets") and
        mob:canUseAbilities() == true
    then
        mob:setLocalVar("pop_pets", os.time() + 150)

        local spawns = mob:getLocalVar("SPAWNS")
        if spawns < 8 then
            local minionOffset = ID.mob.JAILER_OF_LOVE + minionGroup[spawns]
            spawnPets(mob, minionOffset)
        elseif spawns > 8 then
            mob:entityAnimationPacket("casm")
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:timer(3000, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:entityAnimationPacket("shsm")
                    mobArg:SetAutoAttackEnabled(true)
                    mobArg:SetMagicCastingEnabled(true)
                    mobArg:SetMobAbilityEnabled(true)
                    spawnSharks(mobArg)
                end
            end)
        end
        mob:setLocalVar("SPAWNS", spawns + 1)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    if skillId == 734 then
        astralFlowPets()
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 27 do
        local pet = GetMobByID(i)
        if pet:isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    if math.random(100) <= 25 then -- 25% chance to spawn Absolute Virtue
        SpawnMob(ID.mob.ABSOLUTE_VIRTUE)
    end
end

return entity
