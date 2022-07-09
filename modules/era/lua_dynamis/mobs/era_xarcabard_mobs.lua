-----------------------------------
--      Xarcabard Era Module     --
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/status")
require("scripts/globals/dynamis")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

-----------------------------------
--    Dynamis Lord, Ying, Yang   --
-----------------------------------
local lordText = 7281
local yingText = 7289
local yangText = 7290
local busy = {xi.act.MOBABILITY_FINISH, xi.act.MOBABILITY_START, xi.act.MOBABILITY_USING, xi.act.MAGIC_CASTING, xi.act.MAGIC_START, xi.act.MAGIC_FINISH}
local specials =
{
    {xi.jsa.HUNDRED_FISTS, 95, "DL_Hundred_Fists"},
    {xi.jsa.MIGHTY_STRIKES, 95, "DL_Mighty_Strikes"},
    {xi.jsa.BLOOD_WEAPON, 95, "DL_Blood_Weapon"},
    {xi.jsa.CHAINSPELL, 50, "DL_Chainspell"},
}
local function spawnDwagons(oMob, target)
    local zoneID = oMob:getZoneID()
    local zone = oMob:getZone()
    local dwagonVars =
    {
        ["ying_killed"] = {zone:getLocalVar("178"),178, 179, "Ying"},
        ["yang_killed"] = {zone:getLocalVar("177"), 177, 179, "Yang"},
    }
    for key, var in pairs(dwagonVars) do
        xi.dynamis.nmDynamicSpawn(var[2], var[3], true, zoneID, target, oMob, oMob:getID())
    end
end

local function spawnClones(oMob, target)
    local zoneID = oMob:getZoneID()
    local victimList = oMob:getEnmityList()
    local victim1 = utils.randomEntry(victimList)["entity"]
    local victim2 = utils.randomEntry(victimList)["entity"]
    local victim3 = utils.randomEntry(victimList)["entity"]
    local victim4 = utils.randomEntry(victimList)["entity"]
    xi.dynamis.nmDynamicSpawn(179, 179, true, zoneID, victim1, oMob, oMob:getID())
    xi.dynamis.nmDynamicSpawn(179, 179, true, zoneID, victim2, oMob, oMob:getID())
    xi.dynamis.nmDynamicSpawn(179, 179, true, zoneID, victim3, oMob, oMob:getID())
    xi.dynamis.nmDynamicSpawn(179, 179, true, zoneID, victim4, oMob, oMob:getID())
end

xi.dynamis.onSpawnDynaLord = function(mob)
    local zone = mob:getZone()
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setMegaBossStats(mob)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.UFASTCAST, 100)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "DL_WEAPONSKILL_STATE_ENTER", function(mob, skillid)
        if skillid == xi.jsa.HUNDRED_FISTS then
            mob:messageText(mob, lordText + 11)
        elseif skillid == xi.jsa.MIGHTY_STRIKES then
            mob:messageText(mob, lordText + 14)
        elseif skillid == xi.jsa.BLOOD_WEAPON then
            mob:messageText(mob, lordText + 12)
        elseif skillid == xi.jsa.CHAINSPELL then
            mob:messageText(mob, lordText + 13)
        end
    end)
    mob:addListener("WEAPONSKILL_STATE_EXIT", "DL_WEAPONSKILL_STATE_EXIT", function(mobEntity, skillid)
        local zone = mobEntity:getZone()
        if mobEntity:getID() ~= zone:getLocalVar("179") then
            if skillid == zone:getLocalVar("CloneMove") then
                DespawnMob(mobEntity:getID())
            end
        end
    end)
end

xi.dynamis.onSpawnYing = function(mob)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
        if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
            dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
            dynaLord:setMod(xi.mod.UDMGBREATH, -100)
            dynaLord:setLocalVar("magImmune", 0)
        end
    end
end

xi.dynamis.onSpawnYang = function(mob)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setNMStats(mob)
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
        if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
            dynaLord:setMod(xi.mod.UDMGMAGIC, -100)
            dynaLord:setMod(xi.mod.UDMGBREATH, -100)
            dynaLord:setLocalVar("magImmune", 0)
        end
    end
end

xi.dynamis.onEngagedDynaLord = function(mob, target)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    if mob:getLocalVar("Clone") == 1 then
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:setHP(zone:getLocalVar("DL_HP"))
        mob:setLocalVar("ws", 1)
    else
        mob:showText(mob, lordText + 8) -- Immortal Drakes, deafeated
        zone:setLocalVar("teraTime", os.time() + math.random(90,120))
    end
end

xi.dynamis.onFightDynaLord = function(mob, target)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    local cloneMove = zone:getLocalVar("CloneMove")
    local teraTime = zone:getLocalVar("teraTime")
    local ws = mob:getLocalVar("ws")
    local dwagonVars =
    {
        ["ying_killed"] = {zone:getLocalVar("178"),178, 179, "Ying"},
        ["yang_killed"] = {zone:getLocalVar("177"), 177, 179, "Yang"},
    }

    if mob:getID() ~= mainLord then
        mob:SetMagicCastingEnabled(false)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end

    if zone:getLocalVar("dwagonSpawn") == 0 then
        zone:setLocalVar("dwagonSpawn", os.time() + 30)
    end

    if ws == 1 then
        mob:queue(10, function(mob) mob:useMobAbility(cloneMove) mob:setLocalVar("ws", 0) end)
    end

    if mob:getLocalVar("ws") == 0 and mob:getID() == mainLord then
        zone:setLocalVar("DL_HP", mob:getHP())
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:SetAutoAttackEnabled(true)

        if mob:getID() == mainLord and zone:getLocalVar("2hrCool") <= os.time() then
            for _, table in pairs(specials) do
                if zone:getLocalVar(table[3]) ~= 1 and mob:getHPP() <= table[2] then
                    mob:useMobAbility(table[1])
                    zone:setLocalVar(table[3], 1)
                    zone:setLocalVar("2hrCool", os.time() + 30)
                    break
                end
            end
        end

        for key, var in pairs(dwagonVars) do -- Update Ying and Yang to Attack Current Target
            if zone:getLocalVar(key) == 0 then
                local dwagon = GetMobByID(var[1])
                if not dwagon:isEngaged() then
                    dwagon:updateEnmity(target)
                end
            end
        end

        if os.time() > teraTime and mob:getID() == mainLord and mob:getLocalVar("cloneSpawn") <= os.time() then
            mob:setLocalVar("cloneSpawn", os.time() + 5)
            mob:entityAnimationPacket("casm")
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:timer(3000, function(mob, target)
                spawnClones(mob, target)
                zone:setLocalVar("CloneMove", math.random(1131,1135))
                mob:setLocalVar("ws", 1)
                zone:setLocalVar("teraTime", os.time() + math.random(90,120))
                mob:entityAnimationPacket("shsm")
                mob:SetMobAbilityEnabled(true)
            end)
        end

        if zone:getLocalVar("ying_killed") == 1 and zone:getLocalVar("yang_killed") == 1 and zone:getLocalVar("dwagonSpawn") <= os.time() then
            zone:setLocalVar("dwagonSpawn", os.time() + 5)
            if zone:getLocalVar("dwagonLastPop") <= os.time() then -- Spawn Ying and Yang
                mob:SetAutoAttackEnabled(false)
                mob:SetMagicCastingEnabled(false)
                mob:SetMobAbilityEnabled(false)
                mob:entityAnimationPacket("casm")
                mob:timer(3000, function (mob, target)
                    spawnDwagons(mob, target)
                    mob:entityAnimationPacket("shsm")
                    mob:SetAutoAttackEnabled(true)
                    mob:SetMagicCastingEnabled(true)
                    mob:SetMobAbilityEnabled(true)
                    if mob:getLocalVar("initialSpawnDialog") ~= 1 and mob:getID() == mainLord then
                        mob:showText(mob, lordText + 7)
                        mob:setLocalVar("initialSpawnDialog", 1)
                    end
                    zone:setLocalVar("dwagonLastPop", os.time() + 30)
                end)
            end
        end
    end
end

xi.dynamis.onFightYing = function(mob, target)
    local zone = mob:getZone()
    local dwagonVars = {zone:getLocalVar("ying_killed"), zone:getLocalVar("yang_killed"), zone:getLocalVar("178"), zone:getLocalVar("177"), 178, 177, 179, "Ying", "Yang"}
    local yangToD = zone:getLocalVar("yangToD")
    -- Repop Yang every 30 seconds if Ying is up and Yang is not.
    if mob:getLocalVar("Spawning") <= os.time() then
        mob:setLocalVar("Spawning", os.time() + 5)
        if dwagonVars[2] == 1 and os.time() > yangToD + 30 then
            spawnDwagons(mob, target)
        end
    end
end

xi.dynamis.onFightYang = function(mob, target)
    local zone = mob:getZone()
    local dwagonVars = {zone:getLocalVar("ying_killed"), zone:getLocalVar("yang_killed"), zone:getLocalVar("178"), zone:getLocalVar("177"), 178, 177, 179, "Ying", "Yang"}
    local yingToD = zone:getLocalVar("YangToD")
    -- Repop Yang every 30 seconds if Yang is up and Yang is not.
    if mob:getLocalVar("Spawning") <= os.time() then
        mob:setLocalVar("Spawning", os.time() + 5)
        if dwagonVars[2] == 1 and os.time() > yingToD + 30 then
            spawnDwagons(mob, target)
        end
    end
end

xi.dynamis.onMagicPrepDynaLord = function(mob, target)
    local rnd = math.random(1, 100)
    -- Dynamis Lord has a small chance to choose death
    if rnd <= 3 then
        return 367 -- Death
    end
end

xi.dynamis.onWeaponskillPrepDynaLord = function(mob, target)
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    if mob:getHPP() <= 25 then
        local weaponSkills =
        {
            [1135] = {25},
            [1133] = {50},
            [1134] = {75},
            [1132] = {100},
        }
        local randomchance = math.random(1, 100)
        for skill, chance in pairs(weaponSkills) do -- Checks all skills and their chances.
            if chance[1] >= randomchance then -- If chance is less than or equal to skill, use it.
                return skill -- Execute Skill
            end
        end
    end
end

xi.dynamis.onWeaponskillDynaLord = function(mob, skill)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    if skill:getID() == 1135 and mob:getID() == mainLord then
        mob:showText(mob, lordText + 1)
    end
end

xi.dynamis.onDeathDynaLord = function(mob, player, isKiller)
    local zone = mob:getZone()
    xi.dynamis.megaBossOnDeath(mob, player, isKiller)
    if isKiller then
        mob:showText(mob, lordText + 2)
        local dwagons = {zone:getLocalVar("177"), zone:getLocalVar("178")}
        for _, dwagon in pairs(dwagons) do
            DespawnMob(dwagon)
        end
    end
end

xi.dynamis.onDeathYing = function(mob, player, isKiller)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    xi.dynamis.mobOnDeath(mob, player, isKiller)
    if isKiller then
        if zone:getLocalVar("yang_killed") == 0 then
            mob:showText(mob, yingText + 2)
        else
            mob:showText(mob, yingText)
        end
    end

    zone:setLocalVar("yingToD", os.time())
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
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
end

xi.dynamis.onDeathYang = function(mob, player, isKiller)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    xi.dynamis.mobOnDeath(mob, player, isKiller)
    if isKiller then
        if zone:getLocalVar("ying_killed") == 0 then
            mob:showText(mob, yangText + 2)
        else
            mob:showText(mob, yangText)
        end
    end

    zone:setLocalVar("yangToD", os.time())
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
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
    [151] = -- Animated Hammer
    {
        ["Children"] = {180, 181, 182, 183},
        ["Spells"] =
        {
            {xi.magic.spell.PHALANX, 100, xi.effect.PHALANX},
            {xi.magic.spell.HOLY, 100, xi.effect.KO},
        },
    },
    [152] = -- Animated Dagger
    {
        ["Children"] = {184, 185, 186, 187},
        ["Spells"] =
        {
            {xi.magic.spell.AEROGA_III, 50, xi.effect.KO},
            {xi.magic.spell.FLASH, 75, xi.effect.KO},
            {xi.magic.spell.POISONGA_II, 100, xi.effect.KO},
        },
    },
    [153] = -- Animated Shield
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
    [154] = -- Animated Claymore
    {
        ["Children"] = {192, 193, 194, 195},
        ["Spells"] =
        {
            {xi.magic.spell.BLIZZAGA_III, 50, xi.effect.KO},
            {xi.magic.spell.ICE_SPIKES, 75, xi.effect.ICE_SPIKES},
            {xi.magic.spell.SLEEPGA, 100, xi.effect.KO},
        },
    },
    [155] = -- Animated Gun
    {
        ["Children"] = {196, 197, 198, 199},
        ["Spells"] =
        {
            {xi.magic.spell.FLARE, 50, xi.effect.KO},
            {xi.magic.spell.BLAZE_SPIKES, 75, xi.effect.BLAZE_SPIKES},
            {xi.magic.spell.GRAVIGA, 100, xi.effect.KO},
        },
    },
    [156] = -- Animated Longbow
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
    [157] = -- Animated Tachi
    {
        ["Children"] = {204, 205, 206, 207},
        ["Spells"] =
        {
            {xi.magic.spell.CURAGA_III, 25, xi.effect.WEAKNESS},
            {xi.magic.spell.SILENCEGA, 75, xi.effect.KO},
            {xi.magic.spell.BINDGA, 100, xi.effect.KO},
        },
    },
    [158] = -- Animated Tabar
    {
        ["Children"] = {208, 209, 210, 211},
        ["Spells"] =
        {
            {xi.magic.spell.BLINK, 25, xi.effect.BLINK},
            {xi.magic.spell.SLEEPGA, 75, xi.effect.KO},
            {xi.magic.spell.PARALYGA, 100, xi.effect.KO},
        },
    },
    [159] = -- Animated Staff
    {
        ["Children"] = {212, 213, 214, 215},
        ["Spells"] =
        {
            {xi.magic.spell.HOLY, 50, xi.effect.KO},
            {xi.magic.spell.BREAKGA, 100, xi.effect.KO},
        },
    },
    [160] = -- Animated Spear
    {
        ["Children"] = {216, 217, 218, 219},
        ["Spells"] =
        {
            {xi.magic.spell.CURAGA_II, 50, xi.effect.WEAKNESS},
            {xi.magic.spell.THUNDAGA_III, 100, xi.effect.KO},
        },
    },
    [161] = -- Animated Kunai
    {
        ["Children"] = {220, 221, 222, 223},
        ["Spells"] =
        {
            {xi.magic.spell.JUBAKU_NI, 50, xi.effect.KO},
            {xi.magic.spell.KURAYAMI_NI, 100, xi.effect.KO},
        },
    },
    [162] = -- Animated Knuckles
    {
        ["Children"] = {224, 225, 226, 227},
        ["Spells"] =
        {
            {xi.magic.spell.PROTECTRA_IV, 25, xi.effect.PROTECT},
            {xi.magic.spell.BLAZE_SPIKES, 50, xi.effect.BLAZE_SPIKES},
            {xi.magic.spell.HASTEGA, 100, xi.effect.WEAKNESS},
        },
    },
    [163] = -- Animated Great Axe
    {
        ["Children"] = {228, 229, 230, 231},
        ["Spells"] =
        {
            {xi.magic.spell.BLAZE_SPIKES, 25, xi.effect.BLAZE_SPIKES},
            {xi.magic.spell.ABSORB_STR, 75, xi.effect.STR_BOOST},
            {xi.magic.spell.SLOWGA, 100, xi.effect.KO},
        },
    },
    [164] = -- Animated Horn
    {
        ["Children"] = {232, 233, 234, 235},
        ["Spells"] =
        {
            {xi.magic.spell.HORDE_LULLABY, 100, xi.effect.KO},
        },
    },
    [165] = -- Animated Longsword
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
    [166] = -- Animated Scythe
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

        for _, data in pairs(xi.dynamis.animatedInfo[mob:getLocalVar("MobIndex")]["Spells"]) do
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
    if not GetMobByID(mob:getLocalVar("ParentID")) then -- Despawn if Animated Parent Dies
        DespawnMob(mob:getID())
    end
end
