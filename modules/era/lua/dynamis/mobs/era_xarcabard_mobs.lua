-----------------------------------
--      Xarcabard Era Module     --
-----------------------------------
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("scripts/globals/dynamis")
require("scripts/globals/mixins")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

-----------------------------------
--    Dynamis Lord, Ying, Yang   --
-----------------------------------

xi.dynamis.onSpawnDynaLord = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
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
end

xi.dynamis.onSpawnYing = function(mob)
    local zone = mob:getZone()
    local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
        dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
        dynaLord:setMod(xi.mod.UDMGBREATH, -100)
        dynaLord:setLocalVar("magImmune", 0)
        mob:setSpawn(-364, -35.661, 17.254) -- Reset Ying's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end

xi.dynamis.onSpawnYang = function(mob)
    local zone = mob:getZone()
    local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
        dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
        dynaLord:setMod(xi.mod.UDMGBREATH, -100)
        dynaLord:setLocalVar("magImmune", 0)
        mob:setSpawn(-364, -35.661, 17.254) -- Reset Yang's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end

xi.dynamis.onEngagedDynaLord = function(mob, target)
    local dialogDL = 7272
    local zone = mob:getZone()
    mob:setLocalVar("teraTime", os.time() + math.random(90,120))
    mob:setLocalVar("lastPetPop", os.time() + 60)
    local mainLord = zone:getLocalVar("MainDynaLord")
    if mob:getID() == mainLord then
        mob:showText(mob, dialogDL + 8) -- Immortal Drakes, deafeated
    end  
end

xi.dynamis.onFightDynaLord = function(mob, target)
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

    if os.time() - mob:getLocalVar("lastPetPop") > 30 then -- Spawn Ying and Yang
        if not GetMobByID(zone:getLocalVar("Ying")):isAlive() and GetMobByID(zone:getLocalVar("Yang")):isAlive() then
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:entityAnimationPacket("casm")
            mob:timer(3000, function (mob, target)
                local pets = { 177, 178 }
                xi.dynamis.nmDynamicSpawn(pets[1], mob:getLocalVar("MobIndex"), true, mob:getZoneID(), target, mob)
                xi.dynamis.nmDynamicSpawn(pets[2], mob:getLocalVar("MobIndex"), true, mob:getZoneID(), target, mob)
                mob:entityAnimationPacket("shsm")
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(true)
                mob:SetMobAbilityEnabled(true)
                mob:setLocalVar("lastPetPop", os.time() +30)
                if mob:getLocalVar("initialSpawnDialog") ~= 1 and mob:getID() == mainLord then
                    mob:showText(mob, dialogDL + 7)
                    mob:setLocalVar("initialSpawnDialog", 1)
                end
            end)
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
        local spawned = 0
        mob:entityAnimationPacket("casm")
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:timer(3000, function(mob) 
            while i <= 5 do
                local victim = math.random(#targetList)
                local victimPos = targetList[victim].entity:getPos()
                local clone = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = xi.dynamis.nmInfoLookup["Dynamis Lord"][1],
                x = victimPos.x,
                y = victimPos.y,
                z = victimPos.z,
                rotation = mob:getRotPos(),
                groupId = xi.dynamis.nmInfoLookup["Dynamis Lord"][2],
                groupZoneId = xi.dynamis.nmInfoLookup["Dynamis Lord"][3],
                onMobSpawn = function(pet) xi.dynamis.setNMStats(pet) end,
                onMobRoam = function(pet) xi.dynamis.mobOnRoam(pet) end,
                onMobFight = function(pet) xi.dynamis.mobOnFight(pet) end,
                onMobRoamAction = function(pet) xi.dynamis.mobOnRoamAction(pet) end,
                onMobDeath = function(pet, playerArg, isKiller) end,
                })
                clone:setSpawn(victimPos.x, victimPos.y, victimPos.z, mob:getRotPos())
                mob:setDropID(xi.dynamis.nmInfoLookup["Dynamis Lord"][4])
                if xi.dynamis.nmInfoLookup["Dynamis Lord"][5] ~= nil then -- If SpellList ~= nil set SpellList
                    clone:setSpellList(xi.dynamis.nmInfoLookup["Dynamis Lord"][5])
                end
                if xi.dynamis.nmInfoLookup["Dynamis Lord"][6] ~= nil then -- If SkillList ~= nil set SkillList
                    clone:setMobMod(xi.mobMod.SKILL_LIST, xi.dynamis.nmInfoLookup["Dynamis Lord"][6])
                end
                clone:setMobMod(xi.mobMod.SUPERLINK, 1)
                zone:setLocalVar(string.format("Dynamis_Lord_%i", i), clone:getID())
                clone:spawn()
                clone:setHP(mob:getHP())
                clone:updateEnmity(targetList[victim].entity)
                clone:setLocalVar("tpTime", os.time() + 2)
            end
            i = i + 1
            spawned = spawned + 1
        end)
        if spawned ~= 0  then
            mob:entityAnimationPacket("shsm")
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            local newDynaLord = zone:getLocalVar(string.format("Dynamis_Lord_%i", math.random(1, 5)))
            zone:setLocalVar("MainDynaLord", newDynaLord)
        end
    end
end

xi.dynamis.onFightYing = function(mob, target)
    local zone = mob:getZone()
    local yang = GetMobByID(zone:getLocalVar("Yang"))
    local yangToD = mob:getLocalVar("yangToD")
    -- Repop Yang every 30 seconds if Ying is up and Yang is not.
    if not yang:isSpawned() and os.time() > yangToD + 30 then
        yang:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        yang:spawn()
        yang:updateEnmity(target)
    end
end

xi.dynamis.onFightYang = function(mob, target)
    local zone = mob:getZone()
    local Yang = GetMobByID(zone:getLocalVar("Yang"))
    local YangToD = mob:getLocalVar("YangToD")
    -- Repop Yang every 30 seconds if Yang is up and Yang is not.
    if not Yang:isSpawned() and os.time() > YangToD + 30 then
        Yang:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        Yang:spawn()
        Yang:updateEnmity(target)
    end
end

xi.dynamis.onMagicPrepDynaLord = function(mob, target)
    local rnd = math.random(1, 100)
    -- Dynamis Lord has a small chance to choose death
    if rnd <= 5 then
        return 367 -- Death
    end
end

xi.dynamis.onWeaponskillPrepDynaLord = function(mob, target)
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    local weaponSkills = 
    {
        [1135] = {25},
        [1133] = {50},
        [1134] = {75},
        [1132] = {100},
    }
    local randomchance = math.random(1, 100)

    if mob:getHPP() <= 25 then
        for skill, chance in pairs(weaponSkills) do -- Checks all skills and their chances.
            if chance[1] >= randomchance then -- If chance is less than or equal to skill, use it.
                return skill -- Execute Skill
            end
        end
    end
end

xi.dynamis.onWeaponskillDynaLord = function(mob, skill)
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    local dialogDL = 7272
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("MainDynaLord")
    if skill:getID() == 1135 and mob:getID() == mainLord then
        mob:showText(mob, dialogDL + 1)
    end
    mob:setLocalVar("WeaponskillPerformed", 1)
end

xi.dynamis.onDeathDynaLord = function(mob, player, isKiller)
    local zone = mob:getZone()
    local dialogDL = 7272
    xi.dynamis.megaBossOnDeath(mob, player, mobVar)
    if isKiller then
        mob:showText(mob, dialogDL + 2)
        local dwagons = {zone:getLocalVar("Ying"), zone:getLocalVar("Yang")}
        for _, dwagon in pairs(dwagons) do
            if GetMobByID(dwagon):isAlive() then
                DespawnMob(dwagon)
            end
        end
    end
    zone:setLocalVar("MainDynaLord", mob:getID())
end

xi.dynamis.onDeathYing = function(mob, player, isKiller)
    local zone = mob:getZone()
    local yang = GetMobByID(zone:getLocalVar("Yang"))
    local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    local dialogYing = 7289
    if isKiller then
        if yang:isAlive() == true then
            mob:showText(mob, dialogYing)
        else
            mob:showText(mob, dialogYing + 2)
        end
    end

    yang:setLocalVar("yingToD", os.time())
    if dynaLord:getLocalVar("magImmune") == 0 then
        dynaLord:setMod(xi.mod.UDMGMAGIC, 0)
        dynaLord:setMod(xi.mod.UDMGBREATH, 0)
        if dynaLord:getLocalVar("physImmune") == 1 then -- other dragon is also dead
            dynaLord:setLocalVar("physImmune", 2)
            dynaLord:setLocalVar("magImmune", 2)
        else
            dynaLord:setLocalVar("magImmune", 1)
        end
    end
end

xi.dynamis.onDeathYang = function(mob, player, isKiller)
    local zone = mob:getZone()
    local ying = GetMobByID(zone:getLocalVar("Ying"))
    local dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    local dialogYing = 7290
    if isKiller then
        if ying:isAlive() == true then
            mob:showText(mob, dialogYing)
        else
            mob:showText(mob, dialogYing + 2)
        end
    end

    ying:setLocalVar("yingToD", os.time())
    if dynaLord:getLocalVar("physImmune") == 0 then
        dynaLord:setMod(xi.mod.UDMGMAGIC, 0)
        dynaLord:setMod(xi.mod.UDMGBREATH, 0)
        if dynaLord:getLocalVar("magImmune") == 1 then -- other dragon is also dead
            dynaLord:setLocalVar("physImmune", 2)
            dynaLord:setLocalVar("magImmune", 2)
        else
            dynaLord:setLocalVar("physImmune", 1)
        end
    end
end

xi.dynamis.onMobRoamXarc = function(mob)
    local currentPos = mob:getPos()
    local spawnPos = mob:getSpawnPos()
    if currentPos.x ~= spawnPos.x and currentPos.z ~= spawnPos.z then
        mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z)
    end
end

-----------------------------------
--        Animated Weapons       --
-----------------------------------

xi.dynamis.animatedInfo = 
{
    -- [mobIndex] = 
    -- {
    --     ["Children"] = {},
    --     ["Spells"] =
    --     {
    --         [spell1] = {chance, xi.effect.EFFECT},
    --         [spell2] = {chance, xi.effect.EFFECT}, 
    --     },
    -- },
    -- xi.effect.KO is used for if the spell is not enhancing.
    -- Use chance == 100 if there is really only 2 options. See hammer.
    [151] = -- Animated Hammer
    {
        ["Children"] = {180, 181, 182, 183},
        ["Spells"] =
        {
            [106] = {100, xi.effect.PHALANX}, -- Phalanx
            [21] = {100, xi.effect.KO}, -- Holy
        },
    },
    [152] = -- Animated Dagger
    {
        ["Children"] = {184, 185, 186, 187},
        ["Spells"] =
        {
            [186] = {50, xi.effect.KO}, -- Aeroga III
            [112] = {75, xi.effect.KO}, -- Flash
            [226] = {100, xi.effect.KO}, -- Poisonga II
        },
    },
    [153] = -- Animated Shield
    {
        ["Children"] = {188, 189, 190, 191},
        ["Spells"] =
        {
            [106] = {100, xi.effect.PHALANX}, -- Phalanx
            [9] = {50, xi.effect.KO}, -- Curaga III
            [46] = {100, xi.effect.PROTECT}, -- Protect IV
            [273] = {100, xi.effect.KO}, -- Sleepga
        },
    },
    [154] = -- Animated Claymore
    {
        ["Children"] = {192, 193, 194, 195},
        ["Spells"] =
        {
            [181] = {50, xi.effect.KO}, -- Blizzaga III
            [250] = {75, xi.effect.ICE_SPIKES}, -- Ice Spikes
            [273] = {100, xi.effect.KO}, -- Sleepga
        },
    },
    [155] = -- Animated Gun
    {
        ["Children"] = {196, 197, 198, 199},
        ["Spells"] =
        {
            [204] = {50, xi.effect.KO}, -- Flare
            [249] = {75, xi.effect.BLAZE_SPIKES}, -- Blaze Spikes
            [366] = {100, xi.effect.KO}, -- Graviga
        },
    },
    [156] = -- Animated Longbow
    {
        ["Children"] = {200, 201, 202, 203},
        ["Spells"] =
        {
            [9] = {25, xi.effect.KO}, -- Curaga III
            [53] = {50, xi.effect.BLINK}, -- Blink
            [208] = {75, xi.effect.KO}, -- Tornado
            [362] = {100, xi.effect.KO}, -- Bindga
        },
    },
    [157] = -- Animated Tachi
    {
        ["Children"] = {204, 205, 206, 207},
        ["Spells"] =
        {
            [9] = {25, xi.effect.KO}, -- Curaga III
            [359] = {75, xi.effect.KO}, -- Silencega
            [361] = {100, xi.effect.KO}, -- Bindga
        },
    },
    [158] = -- Animated Tabar
    {
        ["Children"] = {208, 209, 210, 211},
        ["Spells"] =
        {
            [53] = {25, xi.effect.BLINK}, -- Blink
            [273] = {75, xi.effect.KO}, -- Sleepga
            [356] = {100, xi.effect.KO}, -- Paralyga
        },
    },
    [159] = -- Animated Staff
    {
        ["Children"] = {212, 213, 214, 215},
        ["Spells"] =
        {
            [21] = {50, xi.effect.KO}, -- Holy
            [365] = {100, xi.effect.KO}, -- Breakga
        },
    },
    [160] = -- Animated Spear
    {
        ["Children"] = {216, 217, 218, 219},
        ["Spells"] =
        {
            [8] = {50, xi.effect.KO}, -- Curaga II
            [196] = {100, xi.effect.KO}, -- Thundaga III
        },
    },
    [161] = -- Animated Kunai
    {
        ["Children"] = {220, 221, 222, 223},
        ["Spells"] =
        {
            [342] = {50, xi.effect.KO}, -- Jubaku: Ni
            [348] = {100, xi.effect.KO}, -- Kurayami: Ni
        },
    },
    [162] = -- Animated Knuckles
    {
        ["Children"] = {224, 225, 226, 227},
        ["Spells"] =
        {
            [128] = {25, xi.effect.PROTECT}, -- Protectra IV
            [249] = {50, xi.effect.BLAZE_SPIKES}, -- Blase Spikes
            [358] = {100, xi.effect.KO}, -- Hastega
        },
    },
    [163] = -- Animated Great Axe
    {
        ["Children"] = {228, 229, 230, 231},
        ["Spells"] =
        {
            [249] = {25, xi.effect.BLAZE_SPIKES}, -- Blaze Spikes
            [266] = {75, xi.effect.STR_BOOST}, -- Absorb - STR
            [357] = {100, xi.effect.KO}, -- Slowga
        },
    },
    [164] = -- Animated Horn
    {
        ["Children"] = {232, 233, 234, 235},
        ["Spells"] =
        {
            [376] = {100, xi.effect.KO}, -- Horde Lullaby
        },
    },
    [165] = -- Animated Longsword
    {
        ["Children"] = {236, 237, 238, 239},
        ["Spells"] =
        {
            [4] = {25, xi.effect.KO}, -- Cure IV
            [9] = {50, xi.effect.KO}, -- Curaga III
            [21] = {75, xi.effect.KO}, -- Holy
            [360] = {100, xi.effect.KO}, -- Dispelga
        },
    },
    [166] = -- Animated Scythe
    {
        ["Children"] = {240, 241, 242, 243},
        ["Spells"] =
        {
            [106] = {25, xi.effect.PHALANX}, -- Phalanx
            [232] = {75, xi.effect.KO}, -- Bio III
            [361] = {100, xi.effect.KO}, -- Bindga
        },
    },
}

xi.dynamis.onSpawnAnimated = function(mob)
    mixins = {require("scripts/mixins/families/animated_weapons"),}
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setAnimatedWeaponstats(mob)
    -- Since mixin is called after spawn function is initiated, adding spawn listener functions here
    mob:SetMagicCastingEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("dialogOne", 4)
    mob:setLocalVar("dialogTwo", 3)
end

xi.dynamis.onEngagedAnimated = function(mob, target)
    xi.dynamis.parentOnEngaged(mob, target)
end

xi.dynamis.onMagicPrepAnimated = function(mob, target)
    local mobIndex = mob:getLocalVar("MobIndex")
    local spells = xi.dynamis.animatedInfo[mobIndex]["Spells"]
    local warp = mob:getLocalVar("warp")
    local pick = math.random(1, 100)

    if warp == 1 then
        return 261 -- Use Warp
    end

    for spell, chance in pairs(spells) do
        if chance[1] <= pick then
            if mob:hasStatusEffect(spell[2]) then
                spell = spell + 1
            else
                return spell
            end
        end
    end
end

xi.dynamis.onDeathAnimated = function(mob)
    local mobIndex = mob:getLocalVar("MobIndex")
    local children = xi.dynamis.animatedInfo[mobIndex]["Children"]
    for _, child in pairs(children) do
        if GetMobByID(mob:getLocalVar("ChildID_%s", child)):isAlive() then
            DespawnMob(mob:getLocalVar("ChildID_%s", child))
        end
    end
end

xi.dynamis.onSpawnSatellite = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    mob:setAnimationSub(math.random(5,6))
end
