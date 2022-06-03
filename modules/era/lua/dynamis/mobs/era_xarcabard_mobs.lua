-----------------------------------
-- Xarcabard Era Module
-----------------------------------
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobSpawn", function(mob)
    mixins = {require("scripts/mixins/job_special"),}
    local dialogDL = 7272
    local zone = mob:getZone()
    xi.dynamis.setMegaBossStats(mob) 
    mob:setMod(xi.mod.SLEEPRESTRAIT, 100)
    mob:setMod(xi.mod.BINDRESTRAIT, 100)
    mob:setMod(xi.mod.GRAVITYRESTRAIT, 100)
    mob:setMod(xi.mod.BINDRESTRAIT, 100)
    mob:setMod(xi.mod.UFASTCAST, 100)
    zone:setLocalVar("MainDynaLord", mob:getID())
    mob:setLocalVar("tpTime", 0)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)

    xi.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = xi.jsa.HUNDRED_FISTS, hpp = 95, begCode = function(mob) mob:messageText(mob, dialogDL + 11) end},
            {id = xi.jsa.MIGHTY_STRIKES, hpp = 95, begCode = function(mob) mob:messageText(mob, dialogDL + 14) end},
            {id = xi.jsa.BLOOD_WEAPON, hpp = 95, begCode = function(mob) mob:messageText(mob, dialogDL + 12) end},
            {id = xi.jsa.CHAINSPELL, hpp = 50, begCode = function(mob) mob:messageText(mob, dialogDL + 13) end},
        },
    })
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobEngaged", function(mob, target)
    local dialogDL = 7272
    local zone = mob:getZone()
    mob:setLocalVar("teraTime", os.time() + math.random(90,120))
    mob:setLocalVar("lastPetPop", os.time() + 60)
    local mainLord = zone:getLocalVar("MainDynaLord")
    if mob:getID() == mainLord then
        mob:showText(mob, dialogDL + 8) -- Immortal Drakes, deafeated
    end  
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobFight", function(mob, target)
    local dialogDL = 7272
    local zone = mob:getZone()
    local tpTime = mob:getLocalVar("tpTime")
    local mainLord = zone:getLocalVar("MainDynaLord")
    local ying = GetMobByID(zone:getLocalVar("Ying"))
    local yang = GetMobByID(zone:getLocalVar("Yang"))
    if os.time() > tpTime and tpTime ~= 0 then
        local cloneMove = zone:getLocalVar("CloneMove")
        mob:useMobAbility(cloneMove)
        mob:setLocalVar("tpTime", 0)
        GetMobByID(mainLord):setLocalVar("teraTime", os.time() + math.random(90,120))
    elseif tpTime == 0 or os.time() > tpTime then
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
    end

    if mob:getLocalVar("WeaponskillPerformed") == 1 and mob:getID() ~= mainLord then
        DespawnMob(mob:getID())
    else
        mob:setLocalVar("WeaponskillPerformed", 0)
    end

    local alreadyPopped = false

    if os.time() - mob:getLocalVar("lastPetPop") > 30 then
        local pets = 
        {
            ["Ying"] = {"4650756b" , 130, 134, 0, nil, nil}, -- Ying
            ["Yang"] = {"4650756b" , 130, 134, 0, nil, nil}, -- Yang
        }
        for _, dwagon in pairs(pets) do
            if GetMobByID(string.format("%s", pets[dwagon])):isAlive() then
                break
            else
                mob:entityAnimationPacket("casm")
                mob:SetAutoAttackEnabled(false)
                mob:SetMagicCastingEnabled(false)
                mob:SetMobAbilityEnabled(false)
                mob:timer(3000, function(mob) 
                    local pet = zone:insertDynamicEntity({
                    objtype = xi.objType.MOB,
                    name = pets[dwagon][1],
                    x = -414.282,
                    y = -44,
                    z = 20.427,
                    rotation = mob:getRotPos(),
                    groupId = pets[dwagon][2],
                    groupZoneId = pets[dwagon][3],
                    onMobDeath = function(pet, playerArg, isKiller) end,
                    })
                    pet:setSpawn(-414.282, -44, 20.427, mob:getRotPos())
                    mob:setDropID(pets[dwagon][4])
                    if pets[dwagon][5] ~= nil then -- If SpellList ~= nil set SpellList
                        pet:setSpellList(pets[dwagon][5])
                    end
                    if pets[dwagon][6] ~= nil then -- If SkillList ~= nil set SkillList
                        pet:setMobMod(xi.mobMod.SKILL_LIST, pets[dwagon][6])
                    end
                    pet:setMobMod(xi.mobMod.SUPERLINK, 1)
                    mob:setLocalVar(string.format("%s", pets[dwagon]), pet:getID())
                    pet:setLocalVar("PetMaster", mob:getID())
                    zone:setLocalVar(string.format("%s", pets[dwagon]), pet:getID())
                    if mob:isAlive() then
                        mob:entityAnimationPacket("shsm")
                        mob:SetAutoAttackEnabled(true)
                        mob:SetMagicCastingEnabled(true)
                        mob:SetMobAbilityEnabled(true)
                        pet:spawn()
                        pet:updateEnmity(target)
                        mob:setLocalVar("lastPetPop", os.time() +30)
                        if mob:getLocalVar("initialSpawnDialog") == 0 and mob:getID() == mainLord then
                            mob:showText(mob, dialogDL +7)
                            mob:setLocalVar("initialSpawnDialog", 1)
                        end
                    end
                end)
            end
        end
    end

    if ying:isAlive() and ying:getCurrentAction() == xi.act.ROAMING then
        ying:updateEnmity(target)
    end
    if yang:isAlive() and yang:getCurrentAction() == xi.act.ROAMING then
        yang:updateEnmity(target)
    end

    -- Dynamis Lord spawns clones of himself 1 1/2 - 2min after pull that use a TP move in unison and despawn after
    local teraTime = mob:getLocalVar("teraTime")
    if os.time() > teraTime and mob:getID() == mainLord then
        local targetList = mob:getEnmityList()
        local i = 1
        mob:entityAnimationPacket("casm")
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        local dynaLordLookup = {}
        mob:timer(3000, function(mob) 
            while i <= 5 do
                local victim = math.random(#targetList)
                local victimPos = targetList[victim].entity:getPos()
                local clone = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = nmInfoLookup["Dynamis Lord"][1],
                x = victimPos.x,
                y = victimPos.y,
                z = victimPos.z,
                rotation = mob:getRotPos(),
                groupId = nmInfoLookup["Dynamis Lord"][2],
                groupZoneId = nmInfoLookup["Dynamis Lord"][3],
                onMobSpawn = function(pet) xi.dynamis.setNMStats(pet) end,
                onMobRoam = function(pet) xi.dynamis.mobOnRoam(pet) end,
                onMobFight = function(pet) xi.dynamis.mobOnFight(pet) end,
                onMobRoamAction = function(pet) xi.dynamis.mobOnRoamAction(pet) end,
                onMobDeath = function(pet, playerArg, isKiller) end,
                })
                clone:setSpawn(victimPos.x, victimPos.y, victimPos.z, mob:getRotPos())
                mob:setDropID(nmInfoLookup["Dynamis Lord"][4])
                if nmInfoLookup["Dynamis Lord"][5] ~= nil then -- If SpellList ~= nil set SpellList
                    clone:setSpellList(nmInfoLookup["Dynamis Lord"][5])
                end
                if nmInfoLookup["Dynamis Lord"][6] ~= nil then -- If SkillList ~= nil set SkillList
                    clone:setMobMod(xi.mobMod.SKILL_LIST, nmInfoLookup["Dynamis Lord"][6])
                end
                clone:setMobMod(xi.mobMod.SUPERLINK, 1)
                zone:setLocalVar(string.format("Dynamis_Lord_%i", i), clone:getID())
                clone:spawn()
                clone:setHP(mob:getHP())
                clone:updateEnmity(targetList[victim].entity)
                clone:setLocalVar("tpTime", os.time() + 2)
            end
            i = i + 1
            if mob:isAlive() then
                mob:entityAnimationPacket("shsm")
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(true)
                mob:SetMobAbilityEnabled(true)
                local newDynaLord = zone:getLocalVar(string.format("Dynamis_Lord_%i", math.random(1, 5)))
                zone:setLocalVar("MainDynaLord", newDynaLord)
            end
        end)
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobMagicPrepare", function(mob, target)
    local rnd = math.random(0, 1000)
    -- Dynamis Lord has a small chance to choose death
    if rnd <= 0.05 then
        return 367 -- Death
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobWeaponskillPrepare", function(mob, target)
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    if mob:getHPP() <= 25 then
        if math.random() < 0.25 then
            return 1135
        elseif math.random() < 0.50 then
            return 1133
        elseif math.random() < 0.75 then
            return 1134
        else
            return 1132
        end
    end
end)

m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobWeaponskill", function(mob, skill)
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    local dialogDL = 7272
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("MainDynaLord")
    if skill:getID() == 1135 and mob:getID() == mainLord then
        mob:showText(mob, dialogDL + 1)
    end
    mob:setLocalVar("WeaponskillPerformed", 1)
end)



m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobRoam", function(mob) xi.dynamis.mobOnRoam(mob) end)
m:addOverride("xi.zones.Dynamis-Xarcabard.mobs.Dynamis_Lord.onMobRoamAction", function(mob) xi.dynamis.mobOnRoamAction(mob) end)
