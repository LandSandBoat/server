-----------------------------------
--      Xarcabard Era Module     --
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
-----------------------------------
xi = xi or {}
xi.dynamis = xi.dynamis or {}

-----------------------------------
--    Dynamis Lord, Ying, Yang   --
-----------------------------------
local lordText = 7284
local yingText = 7301
local yangText = 7302
local specials =
{
    { xi.jsa.HUNDRED_FISTS, 95, "DL_Hundred_Fists" },
    { xi.jsa.MIGHTY_STRIKES, 95, "DL_Mighty_Strikes" },
    { xi.jsa.BLOOD_WEAPON, 95, "DL_Blood_Weapon" },
    { xi.jsa.CHAINSPELL, 50, "DL_Chainspell" },
}

local function spawnDragons(oMob, target)
    local zoneID = oMob:getZoneID()
    local zone = oMob:getZone()
    local dragonVars =
    {
        ["ying_killed"] = { zone:getLocalVar("178"), 178, 179, "Ying" },
        ["yang_killed"] = { zone:getLocalVar("177"), 177, 179, "Yang" },
    }
    for key, var in pairs(dragonVars) do
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
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    xi.dynamis.setMegaBossStats(mob)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.UFASTCAST, 100)
    mob:setMod(xi.mod.MOVE, 20)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 55) -- 90 + 55 = 145 base dmg
    mob:setMod(xi.mod.ATT, 524) -- 580 total
    mob:setMod(xi.mod.DEF, 371) -- 425 total
    mob:setMod(xi.mod.EVA, 320) -- 359 total
    mob:setMod(xi.mod.REFRESH, 500)

    mob:addListener("WEAPONSKILL_STATE_ENTER", "DL_WEAPONSKILL_STATE_ENTER", function(mobArg, skillid)
        if skillid == xi.jsa.HUNDRED_FISTS then
            mobArg:messageText(mobArg, lordText + 11)
        elseif skillid == xi.jsa.MIGHTY_STRIKES then
            mobArg:messageText(mobArg, lordText + 14)
        elseif skillid == xi.jsa.BLOOD_WEAPON then
            mobArg:messageText(mobArg, lordText + 12)
        elseif skillid == xi.jsa.CHAINSPELL then
            mobArg:messageText(mobArg, lordText + 13)
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "DL_WEAPONSKILL_STATE_EXIT", function(mobArg, skillid)
        local zone = mobArg:getZone()
        if mobArg:getLocalVar("Clone") == 1 then
            if skillid == zone:getLocalVar("CloneMove") then
                mobArg:timer(1000, function(mobAr)
                    DespawnMob(mobAr:getID())
                end)
            end
        end
    end)

    mob:addListener("COMBAT_TICK", "DL_JSA_TICK", function(mobAr)
        -- Handle Clone Moves
        if mobAr:getLocalVar("ws") == 1 then
            local move = mobAr:getZone():getLocalVar("CloneMove")
            if move >= 1131 and move < 1134 then
                mobAr:queue(0, function(mobArg)
                    mobArg:setLocalVar("ws", 0)
                    mobArg:setMobAbilityEnabled(true)
                    mobArg:useMobAbility(move)
                end)
            else
                mobAr:queue(0, function(mobArg)
                    mobArg:setLocalVar("ws", 0)
                    mobArg:setMobAbilityEnabled(true)
                    mobArg:useMobAbility(move, mobArg:getTarget())
                end)
            end
        else
            if mobAr:getLocalVar("Clone") == 0 then
                mobAr:getZone():setLocalVar("DL_HP", mobAr:getHP())
                mobAr:setMagicCastingEnabled(true)
                mobAr:setMobAbilityEnabled(true)
                mobAr:setAutoAttackEnabled(true)
            end
        end

        -- Handle JSAs
        if
            mobAr:getLocalVar("Clone") == 0 and
            mobAr:getZone():getLocalVar("2hrCool") <= os.time()
        then
            for _, table in pairs(specials) do
                if mobAr:getZone():getLocalVar(table[3]) ~= 1 and mob:getHPP() <= table[2] then
                    mobAr:queue(0, function(mobArg)
                        mobArg:useMobAbility(table[1])
                        mobArg:setLocalVar("ws", 0)
                    end)

                    mobAr:getZone():setLocalVar(table[3], 1)
                    mobAr:getZone():setLocalVar("2hrCool", os.time() + 30)
                    break
                end
            end
        end
    end)
end

xi.dynamis.onSpawnYing = function(mob)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    mob:addImmunity(xi.immunity.SLEEP)
    xi.dynamis.setNMStats(mob)
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
        if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
            dynaLord:setMod(xi.mod.UDMGPHYS, -1000)
            dynaLord:setMod(xi.mod.UDMGRANGE, -1000)
            dynaLord:setMod(xi.mod.UDMGMAGIC, -1000)
            dynaLord:setMod(xi.mod.UDMGBREATH, -1000)
            dynaLord:setLocalVar("magImmune", 0)
        end
    end
end

xi.dynamis.onSpawnYang = function(mob)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    mob:addImmunity(xi.immunity.SLEEP)
    xi.dynamis.setNMStats(mob)
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
        if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
            dynaLord:setMod(xi.mod.UDMGPHYS, -1000)
            dynaLord:setMod(xi.mod.UDMGRANGE, -1000)
            dynaLord:setMod(xi.mod.UDMGMAGIC, -1000)
            dynaLord:setMod(xi.mod.UDMGBREATH, -1000)
            dynaLord:setLocalVar("magImmune", 0)
        end
    end
end

xi.dynamis.onEngagedDynaLord = function(mob, target)
    local zone = mob:getZone()
    if mob:getLocalVar("Clone") == 1 then
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setHP(zone:getLocalVar("DL_HP"))
        mob:setLocalVar("ws", 1)
    else
        mob:showText(mob, lordText + 8) -- Immortal Drakes, deafeated
        zone:setLocalVar("teraTime", os.time() + math.random(90, 120))
        zone:setLocalVar("dragonLastPop", os.time() + 30)
    end
end

xi.dynamis.onFightDynaLord = function(mob, target)
    local zone = mob:getZone()
    local teraTime = zone:getLocalVar("teraTime")

    if mob:getLocalVar("Clone") == 1 then
        mob:setMagicCastingEnabled(false)
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setDropID(0)
        -- return here to prevent clones from spawning anything additional
        return
    end

    if mob:getLocalVar("ws") == 0 then
        if
            os.time() > teraTime and
            mob:getLocalVar("cloneSpawn") <= os.time()
        then
            mob:setLocalVar("cloneSpawn", os.time() + 5)
            mob:entityAnimationPacket("casm")
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:timer(3000, function(mobArg, targetArg)
                spawnClones(mobArg, targetArg)
                local cloneMoves = { 1131, 1133, 1134 }
                zone:setLocalVar("CloneMove", cloneMoves[math.random(1, #cloneMoves)])
                mobArg:setLocalVar("ws", 1)
                zone:setLocalVar("teraTime", os.time() + math.random(90, 120))
                mobArg:entityAnimationPacket("shsm")
                mobArg:setMobAbilityEnabled(true)
            end)
        end

        if
            zone:getLocalVar("ying_killed") == 1 and
            zone:getLocalVar("yang_killed") == 1 and
            zone:getLocalVar("dragonSpawn") <= os.time()
        then
            zone:setLocalVar("dragonSpawn", os.time() + 5)
            if zone:getLocalVar("dragonLastPop") <= os.time() then -- Spawn Ying and Yang
                mob:setAutoAttackEnabled(false)
                mob:setMagicCastingEnabled(false)
                mob:setMobAbilityEnabled(false)
                mob:entityAnimationPacket("casm")
                mob:timer(3000, function(mobArg, targetArg)
                    spawnDragons(mobArg, targetArg)
                    mobArg:entityAnimationPacket("shsm")
                    mobArg:setAutoAttackEnabled(true)
                    mobArg:setMagicCastingEnabled(true)
                    mobArg:setMobAbilityEnabled(true)
                    if mobArg:getLocalVar("initialSpawnDialog") ~= 1 then
                        mobArg:showText(mobArg, lordText + 7)
                        mobArg:setLocalVar("initialSpawnDialog", 1)
                    end
                end)
            end
        end

        local dragonVars =
        {
            ["ying_killed"] = { zone:getLocalVar("178"), 178, 179, "Ying" },
            ["yang_killed"] = { zone:getLocalVar("177"), 177, 179, "Yang" },
        }

        for key, var in pairs(dragonVars) do -- Update Ying and Yang to Attack Current Target
            if mob:getZone():getLocalVar(key) == 0 then
                local dragon = GetMobByID(var[1])
                if dragon and not dragon:isEngaged() then
                    dragon:updateEnmity(target)
                end
            end
        end
    end
end

xi.dynamis.onFightYing = function(mob, target)
    local zone = mob:getZone()
    local dragonVars = { zone:getLocalVar("ying_killed"), zone:getLocalVar("yang_killed"), zone:getLocalVar("178"), zone:getLocalVar("177"), 178, 177, 179, "Ying", "Yang" }
    local yangToD = zone:getLocalVar("yangToD")
    -- Repop Yang every 30 seconds if Ying is up and Yang is not.
    if mob:getLocalVar("Spawning") <= os.time() then
        mob:setLocalVar("Spawning", os.time() + 5)
        if dragonVars[2] == 1 and os.time() > yangToD + 30 then
            spawnDragons(mob, target)
        end
    end

    if zone:getLocalVar("179") ~= 0 then
        if
            not GetMobByID(zone:getLocalVar("179")) or
            GetMobByID(zone:getLocalVar("179")):getHP() == 0
        then
            DespawnMob(mob:getID())
        end
    end
end

xi.dynamis.onFightYang = function(mob, target)
    local zone = mob:getZone()
    local dragonVars = { zone:getLocalVar("ying_killed"), zone:getLocalVar("yang_killed"), zone:getLocalVar("178"), zone:getLocalVar("177"), 178, 177, 179, "Ying", "Yang" }
    local yingToD = zone:getLocalVar("YangToD")
    -- Repop Yang every 30 seconds if Yang is up and Yang is not.
    if mob:getLocalVar("Spawning") <= os.time() then
        mob:setLocalVar("Spawning", os.time() + 5)
        if dragonVars[2] == 1 and os.time() > yingToD + 30 then
            spawnDragons(mob, target)
        end
    end

    if zone:getLocalVar("179") ~= 0 then
        if
            not GetMobByID(zone:getLocalVar("179")) or
            GetMobByID(zone:getLocalVar("179")):getHP() == 0
        then
            DespawnMob(mob:getID())
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
            [1135] = { 25 },
            [1133] = { 50 },
            [1134] = { 75 },
            [1132] = { 100 },
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
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    if skill:getID() == 1135 and mob:getLocalVar("Clone") == 0 then
        mob:showText(mob, lordText + 1)
    end
end

xi.dynamis.onDeathDynaLord = function(mob, player, optParams)
    local zone = mob:getZone()
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, lordText + 2)
        local dragons = { zone:getLocalVar("177"), zone:getLocalVar("178") }
        for _, dragon in pairs(dragons) do
            DespawnMob(dragon)
        end
    end
end

xi.dynamis.onDeathYing = function(mob, player, optParams)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    xi.dynamis.mobOnDeath(mob, player, optParams)
    if optParams.isKiller then
        if zone:getLocalVar("yang_killed") == 0 then
            mob:showText(mob, yingText + 2)
            zone:setLocalVar("dragonLastPop", os.time() + 30)
        else
            mob:showText(mob, yingText)
        end
    end

    zone:setLocalVar("yingToD", os.time())
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
        if dynaLord:getLocalVar("magImmune") == 0 then
            dynaLord:setMod(xi.mod.UDMGPHYS, 0)
            dynaLord:setMod(xi.mod.UDMGRANGE, 0)
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

xi.dynamis.onDeathYang = function(mob, player, optParams)
    local zone = mob:getZone()
    local mainLord = zone:getLocalVar("179")
    xi.dynamis.mobOnDeath(mob, player, optParams)
    if optParams.isKiller then
        if zone:getLocalVar("ying_killed") == 0 then
            mob:showText(mob, yangText + 2)
            zone:setLocalVar("dragonLastPop", os.time() + 30)
        else
            mob:showText(mob, yangText)
        end
    end

    zone:setLocalVar("yangToD", os.time())
    if mainLord ~= 0 then
        local dynaLord = GetMobByID(mainLord)
        if dynaLord:getLocalVar("physImmune") == 0 then
            dynaLord:setMod(xi.mod.UDMGPHYS, 0)
            dynaLord:setMod(xi.mod.UDMGRANGE, 0)
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
    --         [spell1] = { chance, xi.effect.EFFECT },
    --         [spell2] = { chance, xi.effect.EFFECT },
    --     },
    -- },
    -- xi.effect.KO is used for if the spell is not enhancing.
    -- Use chance == 100 if there is really only 2 options. See hammer.
    [151] = -- Animated Hammer
    {
        ["Children"] = { 180, 181, 182, 183 },
        ["Spells"] =
        {
            { xi.magic.spell.PHALANX, 100, xi.effect.PHALANX },
            { xi.magic.spell.HOLY, 100, xi.effect.KO },
        },
    },
    [152] = -- Animated Dagger
    {
        ["Children"] = { 184, 185, 186, 187 },
        ["Spells"] =
        {
            { xi.magic.spell.AEROGA_III, 50, xi.effect.KO },
            { xi.magic.spell.FLASH, 75, xi.effect.KO },
            { xi.magic.spell.POISONGA_II, 100, xi.effect.KO },
        },
    },
    [153] = -- Animated Shield
    {
        ["Children"] = { 188, 189, 190, 191 },
        ["Spells"] =
        {
            { xi.magic.spell.PHALANX, 100, xi.effect.PHALANX },
            { xi.magic.spell.CURAGA_III, 50, xi.effect.WEAKNESS },
            { xi.magic.spell.PROTECT_IV, 100, xi.effect.PROTECT },
            { xi.magic.spell.SLEEPGA, 100, xi.effect.KO },
        },
    },
    [154] = -- Animated Claymore
    {
        ["Children"] = { 192, 193, 194, 195 },
        ["Spells"] =
        {
            { xi.magic.spell.BLIZZAGA_III, 50, xi.effect.KO },
            { xi.magic.spell.ICE_SPIKES, 75, xi.effect.ICE_SPIKES },
            { xi.magic.spell.SLEEPGA, 100, xi.effect.KO },
        },
    },
    [155] = -- Animated Gun
    {
        ["Children"] = { 196, 197, 198, 199 },
        ["Spells"] =
        {
            { xi.magic.spell.FLARE, 50, xi.effect.KO },
            { xi.magic.spell.BLAZE_SPIKES, 75, xi.effect.BLAZE_SPIKES },
            { xi.magic.spell.GRAVIGA, 100, xi.effect.KO },
        },
    },
    [156] = -- Animated Longbow
    {
        ["Children"] = { 200, 201, 202, 203 },
        ["Spells"] =
        {
            { xi.magic.spell.CURAGA_III, 25, xi.effect.WEAKNESS },
            { xi.magic.spell.BLINK, 50, xi.effect.BLINK },
            { xi.magic.spell.TORNADO, 75, xi.effect.KO },
            { xi.magic.spell.BINDGA, 100, xi.effect.KO },
        },
    },
    [157] = -- Animated Tachi
    {
        ["Children"] = { 204, 205, 206, 207 },
        ["Spells"] =
        {
            { xi.magic.spell.CURAGA_III, 25, xi.effect.WEAKNESS },
            { xi.magic.spell.SILENCEGA, 75, xi.effect.KO },
            { xi.magic.spell.BINDGA, 100, xi.effect.KO },
        },
    },
    [158] = -- Animated Tabar
    {
        ["Children"] = { 208, 209, 210, 211 },
        ["Spells"] =
        {
            { xi.magic.spell.BLINK, 25, xi.effect.BLINK },
            { xi.magic.spell.SLEEPGA, 75, xi.effect.KO },
            { xi.magic.spell.PARALYGA, 100, xi.effect.KO },
        },
    },
    [159] = -- Animated Staff
    {
        ["Children"] = { 212, 213, 214, 215 },
        ["Spells"] =
        {
            { xi.magic.spell.HOLY, 50, xi.effect.KO },
            { xi.magic.spell.BREAKGA, 100, xi.effect.KO },
        },
    },
    [160] = -- Animated Spear
    {
        ["Children"] = { 216, 217, 218, 219 },
        ["Spells"] =
        {
            { xi.magic.spell.CURAGA_II, 50, xi.effect.WEAKNESS },
            { xi.magic.spell.THUNDAGA_III, 100, xi.effect.KO },
        },
    },
    [161] = -- Animated Kunai
    {
        ["Children"] = { 220, 221, 222, 223 },
        ["Spells"] =
        {
            { xi.magic.spell.JUBAKU_NI, 50, xi.effect.KO },
            { xi.magic.spell.KURAYAMI_NI, 100, xi.effect.KO },
        },
    },
    [162] = -- Animated Knuckles
    {
        ["Children"] = { 224, 225, 226, 227 },
        ["Spells"] =
        {
            { xi.magic.spell.PROTECTRA_IV, 25, xi.effect.PROTECT },
            { xi.magic.spell.BLAZE_SPIKES, 50, xi.effect.BLAZE_SPIKES },
            { xi.magic.spell.HASTEGA, 100, xi.effect.WEAKNESS },
        },
    },
    [163] = -- Animated Great Axe
    {
        ["Children"] = { 228, 229, 230, 231 },
        ["Spells"] =
        {
            { xi.magic.spell.BLAZE_SPIKES, 25, xi.effect.BLAZE_SPIKES },
            { xi.magic.spell.ABSORB_STR, 75, xi.effect.STR_BOOST },
            { xi.magic.spell.SLOWGA, 100, xi.effect.KO },
        },
    },
    [164] = -- Animated Horn
    {
        ["Children"] = { 232, 233, 234, 235 },
        ["Spells"] =
        {
            { xi.magic.spell.HORDE_LULLABY, 100, xi.effect.KO },
        },
    },
    [165] = -- Animated Longsword
    {
        ["Children"] = { 236, 237, 238, 239 },
        ["Spells"] =
        {
            { xi.magic.spell.CURE_IV, 25, xi.effect.WEAKNESS },
            { xi.magic.spell.CURAGA_III, 50, xi.effect.WEAKNESS },
            { xi.magic.spell.HOLY, 75, xi.effect.KO },
            { xi.magic.spell.DISPELGA, 100, xi.effect.KO },
        },
    },
    [166] = -- Animated Scythe
    {
        ["Children"] = { 240, 241, 242, 243 },
        ["Spells"] =
        {
            { xi.magic.spell.PHALANX, 25, xi.effect.PHALANX },
            { xi.magic.spell.BIO_III, 75, xi.effect.KO },
            { xi.magic.spell.BINDGA, 100, xi.effect.KO },
        },
    },
}

xi.dynamis.onSpawnAnimated = function(mob)
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    xi.dynamis.setAnimatedWeaponStats(mob)
    mob:timer(500, function(mobArg)
        mobArg:setAnimationSub(3)
    end)
end

xi.dynamis.onEngagedAnimated = function(mob, target)
    mob:setLocalVar("changeTime", os.time() + math.random(20, 30))
    mob:setLocalVar("castTime", os.time() + math.random(8, 10))
end

xi.dynamis.onFightAnimated = function(mob, target)
    local chosenTarget = mob

    if mob:getLocalVar("animSwap") == 0 then
        mob:setLocalVar("animSwap", 1)
        mob:setAnimationSub(3)
    end

    if mob:getLocalVar("changeTime") <= os.time() then
        mob:addMP(200)
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
                    mob:setLocalVar("castTime", os.time() + math.random(18, 25))
                    break
                end
            end
        end
    end
end

xi.dynamis.onSpawnSatellite = function(mob)
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    xi.dynamis.setNMStats(mob)
    mob:timer(500, function(mobArg)
        mobArg:setLocalVar("animSub", math.random(5, 6))
        mobArg:setAnimationSub(mobArg:getLocalVar("animSub"))
    end)
end

xi.dynamis.onEngageSatellite = function(mob, target)
end

xi.dynamis.onFightSatellite = function(mob, target)
    if mob:getLocalVar("animSwap") == 0 then
        mob:setLocalVar("animSwap", 1)
        mob:setAnimationSub(mob:getLocalVar("animSub"))
    end

    if
        not GetMobByID(mob:getLocalVar("ParentID")) or
        GetMobByID(mob:getLocalVar("ParentID")):getHP() == 0
    then -- Despawn if Animated Parent Dies
        DespawnMob(mob:getID())
    end
end
