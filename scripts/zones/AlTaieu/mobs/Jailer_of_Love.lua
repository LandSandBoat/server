-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Love
-- !pos 431.522 -0.912 -603.503 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.lastEnmityList = {}

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
    [1] = 5025, -- Fire List
    [2] = 5026, -- Ice List
    [3] = 5027, -- Wind List
    [4] = 5028, -- Earth List
    [5] = 5029, -- Ltng List
    [6] = 5030, -- Water List
    [7] = 5024, -- Light List
    [8] = 5031, -- Dark List
}

-- Animations, action IDs and elemental absorb mods are directly mapped to eachother per retail caps
-- in the "standard" order, Fire Ice Wind Earth Thunder Water Holy Dark
local eleAbsorbModID      = { 459, 460, 461, 462, 463, 464, 465, 466 }
local eleAbsorbActionID   = { 603, 604, 624, 404, 625, 626, 627, 307 }
local eleAbsorbAnimations = { 432, 433, 434, 435, 436, 437, 438, 439 }

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
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:timer(3000, function(mobArg)
        if mobArg:isAlive() then
            mobArg:entityAnimationPacket("shsm")
            mobArg:setAutoAttackEnabled(true)
            mobArg:setMagicCastingEnabled(true)
            mobArg:setMobAbilityEnabled(true)
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
        local phuabo = GetMobByID(phuaboDn[i])

        if phuabo then
            phuabo:setSpawn(target:getXPos() + math.random(-2, 2), target:getYPos(), target:getZPos())
            SpawnMob(phuaboDn[i])
            phuabo:setMobMod(xi.mobMod.SUPERLINK, mob:getTargID())
            phuabo:updateEnmity(target)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setBehaviour(2)
    mob:setMagicCastingEnabled(true)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGEN, 260)
    mob:setMod(xi.mod.DMGMAGIC, -5000) -- starts the fight with -50% magic damage taken, reduced to 25% after regen is taken off.
    mob:setMod(xi.mod.ATT, 452)
    mob:setMod(xi.mod.DEF, 620)
    mob:setMod(xi.mod.EVA, 328)

    mob:addImmunity(xi.immunity.SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.REQUIEM)
    mob:addImmunity(xi.immunity.TERROR)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.ASTRAL_FLOW, hpp = math.random(45, 55) },
        },
    })
end

entity.onMobEngaged = function(mob, target)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setMagicCastingEnabled(true)
    mob:setAnimationSub(2)
    mob:setLocalVar("elementAbsorb", os.time() + 120)
    mob:setLocalVar("pop_pets", os.time() + 150) -- wait 2.5 minutes until spawning initial mobs
    mob:setLocalVar("currentAbsorb", math.random(#eleAbsorbModID)) -- pick a random element to absorb after engaging
    mob:setSpellList(spellLists[mob:getLocalVar('currentAbsorb')])
    mob:setMod(eleAbsorbModID[mob:getLocalVar('currentAbsorb')], 100)
end

entity.onMobFight = function(mob, target)
    mob:setAnimationSub(2)

    -- reduce regen after nine Xzomits and Hpemdes (total of both) groups are killed
    if
        mob:getLocalVar("JoL_Regen_Reduction") == 0 and
        mob:getLocalVar("JoL_Qn_xzomit_Killed") >= 9 and
        mob:getLocalVar("JoL_Qn_hpemde_Killed") >= 9
    then
        mob:setLocalVar("JoL_Regen_Reduction", 1)
        mob:delMod(xi.mod.REGEN, 260)
        mob:setMod(xi.mod.DMGMAGIC, -2500) -- magic damage taken reduced from 50% to 25% after killing nine xzomits and hpemdes
    end

    -- every 2 minutes JoL will change the element it absorbs/casts spells this change happens after a two hour animation
    if os.time() > mob:getLocalVar("elementAbsorb") then

        local previousAbsorb = mob:getLocalVar("currentAbsorb")
        mob:setLocalVar("elementAbsorb", os.time() + 60)
        mob:setLocalVar("twohour_tp", mob:getTP())

        -- remove previous absorb mod, if set
        if previousAbsorb > 0 then
            mob:setMod(eleAbsorbModID[previousAbsorb], 0)
        end

        -- add new absorb mod
        local currentAbsorb = math.random(#eleAbsorbModID)
        mob:setLocalVar("currentAbsorb", currentAbsorb)

        -- Inject 2hr animation based on element, this shows in the captures.
        mob:injectActionPacket(mob:getID(), 11, eleAbsorbAnimations[currentAbsorb], 0x18, 0, 0, eleAbsorbActionID[currentAbsorb], 0)
        mob:setSpellList(spellLists[mob:getLocalVar('currentAbsorb')])

        mob:setMod(eleAbsorbModID[currentAbsorb], 100)
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end

    -- spawn minions in 2.5 minute intervals
    if
        os.time() > mob:getLocalVar("pop_pets") and
        mob:canUseAbilities()
    then
        mob:setLocalVar("pop_pets", os.time() + 150)

        local spawns = mob:getLocalVar("SPAWNS")
        if spawns < 8 then
            local minionOffset = ID.mob.JAILER_OF_LOVE + minionGroup[spawns]
            spawnPets(mob, minionOffset)
        elseif spawns > 8 then
            mob:entityAnimationPacket("casm")
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:timer(3000, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:entityAnimationPacket("shsm")
                    mobArg:setAutoAttackEnabled(true)
                    mobArg:setMagicCastingEnabled(true)
                    mobArg:setMobAbilityEnabled(true)
                    spawnSharks(mobArg)
                end
            end)
        end

        mob:setLocalVar("SPAWNS", spawns + 1)
    end

    -- empty table
    for key in pairs (entity.lastEnmityList) do
        entity.lastEnmityList[key] = nil
    end

    local enmityList = mob:getEnmityList()
    for index in ipairs(enmityList) do

        entity.lastEnmityList[index] = {}
        local tempEntity = enmityList[index]["entity"]
        local ce         = enmityList[index]["ce"]
        local ve         = enmityList[index]["ve"]

        entity.lastEnmityList[index]["id"] = tempEntity:getID()
        entity.lastEnmityList[index]["ce"] = ce
        entity.lastEnmityList[index]["ve"] = ve
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    if skillId == 734 then
        astralFlowPets()
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 27 do
        local pet = GetMobByID(i)
        if pet:isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    if math.random(1, 100) <= 25 then -- 25% chance to spawn Absolute Virtue
        local highestEnmityTarget = nil
        local highestEnmity = -1

        for index in ipairs(entity.lastEnmityList) do
            local id = entity.lastEnmityList[index]["id"]
            local ce = entity.lastEnmityList[index]["ce"]
            local ve = entity.lastEnmityList[index]["ve"]

            local target = GetPlayerByID(id)
            if target == nil then
                -- try mob
                target = GetEntityByID(id, mob:getInstance(), true)
            end

            local enmity = ce + ve
            if target then
                if enmity > highestEnmity then
                    highestEnmityTarget = target
                    highestEnmity       = enmity
                end
            end
        end

        SpawnMob(ID.mob.ABSOLUTE_VIRTUE)
        if highestEnmityTarget then
            GetMobByID(ID.mob.ABSOLUTE_VIRTUE):updateEnmity(highestEnmityTarget)
        end
    end
end

return entity
