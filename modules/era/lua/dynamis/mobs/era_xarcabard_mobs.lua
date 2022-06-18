-----------------------------------
--      Xarcabard Era Module     --
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/zone")
require("scripts/globals/spell_data")
require("scripts/globals/status")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

-----------------------------------
--    Dynamis Lord, Ying, Yang   --
-----------------------------------

xi.dynamis.onSpawnDynaLord = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    local dialogDL = 7272
    local zone = mob:getZone()
    xi.dynamis.setMegaBossStats(mob) 
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.UFASTCAST, 100)
    mob:setLocalVar("tpTime", 0)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)

    if zone:getLocalVar("MainDynaLord") == 0 then
        zone:setLocalVar("MainDynaLord", mob:getID())
    end

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
    local dynaLord = 0
    if zone:getLocalVar("MainDynaLord") ~= 0 then
        dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    end
    zone:setLocalVar("ying_killed", 0)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    if dynaLord ~= 0 then
        if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
            dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
            dynaLord:setMod(xi.mod.UDMGBREATH, -100)
            dynaLord:setLocalVar("magImmune", 0)
            mob:setSpawn(-364, -35.661, 17.254) -- Reset Ying's spawn point to initial spot.
        else
            mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
        end
    end
end

xi.dynamis.onSpawnYang = function(mob)
    local zone = mob:getZone()
    local dynaLord = 0
    if zone:getLocalVar("MainDynaLord") ~= 0 then
        dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    end
    zone:setLocalVar("yang_killed", 0)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    if dynaLord ~= 0 then
        if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
            dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
            dynaLord:setMod(xi.mod.UDMGBREATH, -100)
            dynaLord:setLocalVar("magImmune", 0)
            mob:setSpawn(-364, -35.661, 17.254) -- Reset Yang's spawn point to initial spot.
        else
            mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
        end
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

    if zone:getLocalVar("ying_killed") == 0 then
        local ying =  GetMobByID(zone:getLocalVar("178"))
        if ying:getCurrentAction() == xi.act.ROAMING then
            ying:updateEnmity(target)
        end
    end
    if zone:getLocalVar("yang_killed") == 0 then
        local yang = GetMobByID(zone:getLocalVar("177"))
        if yang:getCurrentAction() == xi.act.ROAMING then
            yang:updateEnmity(target)
        end
    end

    if zone:getLocalVar("ying_killed") == 1 and zone:getLocalVar("yang_killed") == 1 and mob:getLocalVar("Spawning") <= os.time() then
        mob:setLocalVar("Spawning", os.time() + 5)
        if mob:getLocalVar("lastPetPop") <= os.time() then -- Spawn Ying and Yang
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:entityAnimationPacket("casm")
            mob:setLocalVar("lastPetPop", os.time() + 33)
            mob:timer(3000, function (mob, target)
                local pets = { 177, 178 }
                xi.dynamis.nmDynamicSpawn(pets[1], mob:getLocalVar("MobIndex"), true, mob:getZoneID(), target, mob)
                xi.dynamis.nmDynamicSpawn(pets[2], mob:getLocalVar("MobIndex"), true, mob:getZoneID(), target, mob)
                mob:entityAnimationPacket("shsm")
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(true)
                mob:SetMobAbilityEnabled(true)
                if mob:getLocalVar("initialSpawnDialog") ~= 1 and mob:getID() == mainLord then
                    mob:showText(mob, dialogDL + 7)
                    mob:setLocalVar("initialSpawnDialog", 1)
                end
            end)
        end
    end

    -- Dynamis Lord spawns clones of himself 1 1/2 - 2min after pull that use a TP move in unison and despawn after
    local teraTime = mob:getLocalVar("teraTime")
    if os.time() > teraTime and mob:getID() == mainLord then
        mob:setLocalVar("terraTime", os.time() + 5)
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
                onMobSpawn = function(mob) xi.dynamis.onSpawnDynaLord(mob) end,
                onMobEngaged = function (mob, target) xi.dynamis.onEngagedDynaLord(mob, target) end,
                onMobRoam = function(mob) xi.dynamis.onMobRoamXarc(mob) end,
                onMobFight = function(mob, target) xi.dynamis.onFightDynaLord(mob, target) end,
                onMobDeath = function(mob, player, isKiller) xi.dynamis.onDeathDynaLord(mob, player, isKiller) end,
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
        if spawned ~= 0 then
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
    local yangToD = mob:getLocalVar("yangToD")
    -- Repop Yang every 30 seconds if Ying is up and Yang is not.
    if zone:getLocalVar("yang_killed") == 1 and os.time() > yangToD + 30 then
        xi.dynamis.nmDynamicSpawn( 177, mob:getLocalVar("MobIndex"), true, mob:getZoneID(), target, mob)
    end
end

xi.dynamis.onFightYang = function(mob, target)
    local zone = mob:getZone()
    local yingToD = mob:getLocalVar("YangToD")
    -- Repop Yang every 30 seconds if Yang is up and Yang is not.
    if zone:getLocalVar("ying_killed") == 1 and os.time() > yingToD + 30 then
        xi.dynamis.nmDynamicSpawn( 178, mob:getLocalVar("MobIndex"), true, mob:getZoneID(), target, mob)
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
        local dwagons = {{zone:getLocalVar("Ying"), zone:getLocalVar("ying_killed")}, {zone:getLocalVar("Yang"), zone:getLocalVar("yang_killed")}}
        for _, dwagon in pairs(dwagons) do
            if dwagon[2] == 0 then
                DespawnMob(dwagon[1])
            end
        end
    end
    zone:setLocalVar("MainDynaLord", mob:getID())
end

xi.dynamis.onDeathYing = function(mob, player, isKiller)
    local zone = mob:getZone()
    local dynaLord = 0
    if zone:getLocalVar("MainDynaLord") ~= 0 then
        dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    end
    local dialogYing = 7289
    if isKiller then
        if zone:getLocalVar("yang_killed") == 0 then
            mob:showText(mob, dialogYing + 2)
        else
            mob:showText(mob, dialogYing)
        end
    end

    mob:setLocalVar("yingToD", os.time())
    if dynaLord ~= 0 then
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

    xi.dynamis.mobOnDeath(mob)
end

xi.dynamis.onDeathYang = function(mob, player, isKiller)
    local zone = mob:getZone()
    local dynaLord = 0
    if zone:getLocalVar("MainDynaLord") ~= 0 then
        dynaLord = GetMobByID(zone:getLocalVar("MainDynaLord"))
    end
    local dialogYang = 7290
    if isKiller then
        if zone:getLocalVar("ying_killed") == 0 then
            mob:showText(mob, dialogYang + 2)
        else
            mob:showText(mob, dialogYang)
        end
    end

    mob:setLocalVar("yangToD", os.time())
    if dynaLord ~= 0 then
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

    xi.dynamis.mobOnDeath(mob)
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
    -- [mobName] = 
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
    ["DE_AHam"] = -- Animated Hammer
    {
        ["Children"] = {180, 181, 182, 183},
        ["Spells"] =
        {
            {xi.magic.spell.PHALANX, 100, xi.effect.PHALANX},
            {xi.magic.spell.HOLY, 100, xi.effect.KO},
        },
    },
    ["DE_ADag"] = -- Animated Dagger
    {
        ["Children"] = {184, 185, 186, 187},
        ["Spells"] =
        {
            {xi.magic.spell.AEROGA_III, 50, xi.effect.KO},
            {xi.magic.spell.FLASH, 75, xi.effect.KO},
            {xi.magic.spell.POISONGA_II, 100, xi.effect.KO},
        },
    },
    ["DE_AShi"] = -- Animated Shield
    {
        ["Children"] = {188, 189, 190, 191},
        ["Spells"] =
        {
            {xi.magic.spell.PHALANX, 100, xi.effect.PHALANX},
            {xi.magic.spell.CURAGA_III, 50, xi.effect.WEAKNESS},
            {xi.magic.spell.PROTECT_IV, 100, xi.effect.PROTECT},
            {xi.magic.spell.SLEEPGA, 100, xi.effect.KO},
        },
    },
    ["DE_ACla"] = -- Animated Claymore
    {
        ["Children"] = {192, 193, 194, 195},
        ["Spells"] =
        {
            {xi.magic.spell.BLIZZAGA_III, 50, xi.effect.KO},
            {xi.magic.spell.ICE_SPIKES, 75, xi.effect.ICE_SPIKES},
            {xi.magic.spell.SLEEPGA, 100, xi.effect.KO},
        },
    },
    ["DE_AGun"] = -- Animated Gun
    {
        ["Children"] = {196, 197, 198, 199},
        ["Spells"] =
        {
            {xi.magic.spell.FLARE, 50, xi.effect.KO},
            {xi.magic.spell.BLAZE_SPIKES, 75, xi.effect.BLAZE_SPIKES},
            {xi.magic.spell.GRAVIGA, 100, xi.effect.KO},
        },
    },
    ["DE_Alon"] = -- Animated Longbow
    {
        ["Children"] = {200, 201, 202, 203},
        ["Spells"] =
        {
            {xi.magic.spell.CURAGA_III, 25, xi.effect.WEAKNESS},
            {xi.magic.spell.BLINK, 50, xi.effect.BLINK},
            {xi.magic.spell.TORNADO, 75, xi.effect.KO},
            {xi.magic.spell.BINDGA, 100, xi.effect.KO},
        },
    },
    ["DE_ATac"] = -- Animated Tachi
    {
        ["Children"] = {204, 205, 206, 207},
        ["Spells"] =
        {
            {xi.magic.spell.CURAGA_III, 25, xi.effect.WEAKNESS},
            {xi.magic.spell.SILENCEGA, 75, xi.effect.KO},
            {xi.magic.spell.BINDGA, 100, xi.effect.KO},
        },
    },
    ["DE_ATab"] = -- Animated Tabar
    {
        ["Children"] = {208, 209, 210, 211},
        ["Spells"] =
        {
            {xi.magic.spell.BLINK, 25, xi.effect.BLINK},
            {xi.magic.spell.SLEEPGA, 75, xi.effect.KO},
            {xi.magic.spell.PARALYGA, 100, xi.effect.KO},
        },
    },
    ["DE_ASta"] = -- Animated Staff
    {
        ["Children"] = {212, 213, 214, 215},
        ["Spells"] =
        {
            {xi.magic.spell.HOLY, 50, xi.effect.KO},
            {xi.magic.spell.BREAKGA, 100, xi.effect.KO},
        },
    },
    ["DE_ASpe"] = -- Animated Spear
    {
        ["Children"] = {216, 217, 218, 219},
        ["Spells"] =
        {
            {xi.magic.spell.CURAGA_II, 50, xi.effect.WEAKNESS},
            {xi.magic.spell.THUNDAGA_III, 100, xi.effect.KO},
        },
    },
    ["DE_AKun"] = -- Animated Kunai
    {
        ["Children"] = {220, 221, 222, 223},
        ["Spells"] =
        {
            {xi.magic.spell.JUBAKU_NI, 50, xi.effect.KO},
            {xi.magic.spell.KURAYAMI_NI, 100, xi.effect.KO},
        },
    },
    ["DE_AKnu"] = -- Animated Knuckles
    {
        ["Children"] = {224, 225, 226, 227},
        ["Spells"] =
        {
            {xi.magic.spell.PROTECTRA_IV, 25, xi.effect.PROTECT},
            {xi.magic.spell.BLAZE_SPIKES, 50, xi.effect.BLAZE_SPIKES},
            {xi.magic.spell.HASTEGA, 100, xi.effect.WEAKNESS},
        },
    },
    ["DE_AGre"] = -- Animated Great Axe
    {
        ["Children"] = {228, 229, 230, 231},
        ["Spells"] =
        {
            {xi.magic.spell.BLAZE_SPIKES, 25, xi.effect.BLAZE_SPIKES},
            {xi.magic.spell.ABSORB_STR, 75, xi.effect.STR_BOOST},
            {xi.magic.spell.SLOWGA, 100, xi.effect.KO},
        },
    },
    ["DE_AHor"] = -- Animated Horn
    {
        ["Children"] = {232, 233, 234, 235},
        ["Spells"] =
        {
            {xi.magic.spell.HORDE_LULLABY, 100, xi.effect.KO},
        },
    },
    ["DE_ALon"] = -- Animated Longsword
    {
        ["Children"] = {236, 237, 238, 239},
        ["Spells"] =
        {
            {xi.magic.spell.CURE_IV, 25, xi.effect.WEAKNESS},
            {xi.magic.spell.CURAGA_III, 50, xi.effect.WEAKNESS},
            {xi.magic.spell.HOLY, 75, xi.effect.KO},
            {xi.magic.spell.DISPELGA, 100, xi.effect.KO},
        },
    },
    ["DE_AScy"] = -- Animated Scythe
    {
        ["Children"] = {240, 241, 242, 243},
        ["Spells"] =
        {
            {xi.magic.spell.PHALANX, 25, xi.effect.PHALANX},
            {xi.magic.spell.BIO_III, 75, xi.effect.KO},
            {xi.magic.spell.BINDGA, 100, xi.effect.KO},
        },
    },
}
xi.dynamis.satelliteInfo =
{
    ["DE_5348616d"] = {"hammer_killed"},
    ["DE_5344616"] = {"dagger_killed"},
    ["DE_53536869"] = {"shield_killed"},
    ["DE_53436c61"] = {"claymore_killed"},
    ["DE_5347756e"] = {"gun_killed"},
    ["DE_536c6f6e"] = {"longbow_killed"},
    ["DE_53546163"] = {"tachi_killed"},
    ["DE_53546162"] = {"tabar_killed"},
    ["DE_53537461"] = {"staff_killed"},
    ["DE_53537065"] = {"spear_killed"},
    ["DE_534b756e"] = {"kunai_killed"},
    ["DE_534b6e75"] = {"knuckles_killed"},
    ["DE_53477265"] = {"gaxe_killed"},
    ["DE_53486f72"] = {"horn_killed"},
    ["DE_534c6f6e"] = {"longsword_killed"},
    ["DE_53536379"] = {"scythe_killed"},
}

xi.dynamis.onSpawnAnimated = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setAnimatedWeaponStats(mob)
end

xi.dynamis.onEngagedAnimated = function(mob, target)
    xi.dynamis.parentOnEngaged(mob, target)
    mob:setLocalVar("castTime", os.time() + math.random(0, 3))
    mob:setLocalVar("changeTime", os.time() + math.random(20, 30))
end

xi.dynamis.onFightAnimated = function(mob, target)
    local chosenTarget = mob

    if mob:getLocalVar("changeTime") <= os.time() then
        mob:castSpell(xi.magic.spell.WARP, chosenTarget)
        mob:setLocalVar("changeTime", os.time() + math.random(10, 15))
    end

    if mob:getLocalVar("castTime") <= os.time() then
        local pick = math.random(1, 100)

        for _, data in pairs(xi.dynamis.animatedInfo[mob:getName()]["Spells"]) do
            if data[2] <= pick then
                if not mob:hasStatusEffect(data[3]) then
                    if data[3] == xi.effect.KO then
                        chosenTarget = target
                    end
                    mob:castSpell(data[1], chosenTarget)
                    mob:setLocalVar("castTime", os.time() + math.random(5, 10))
                    break
                end
            end
        end
    end
end

xi.dynamis.onSpawnSatellite = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    mob:setAnimationSub(math.random(5,6))
end

xi.dynamis.onFightSatellite = function(mob, target)
    print(xi.dynamis.satelliteInfo[mob:getName()][1])
    print(mob:getZone():getLocalVar(string.format("%s", xi.dynamis.satelliteInfo[mob:getName()][1])))
    if mob:getZone():getLocalVar(string.format("%s", xi.dynamis.satelliteInfo[mob:getName()][1])) == 1 then -- Despawn if Animated Parent Dies
        mob:setHP(0)
    end
end
