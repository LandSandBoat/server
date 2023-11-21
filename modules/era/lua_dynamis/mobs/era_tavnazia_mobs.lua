-----------------------------------
--      Tavnazia Era Module      --
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
local ID = require('scripts/zones/Dynamis-Tavnazia/IDs')
-----------------------------------
xi = xi or {}
xi.dynamis = xi.dynamis or {}

local wormPositions =
{
    { -0.4922, -22.75, -26.778, 193 },
    { -21.282, -21.991, -21.588, 226 },
    { -20.901, -22, 21.3637, 34 },
    { 0.183, -22.75, 24.414, 62 },
    { 30.721, -22, -2.156, 142 },
}

local antlionPositions =
{
    { 19.105, -36, 18.66, 100 },
    { 19.72, -35.8, -18.83, 164 },
    { -19.13, -35.94, -19.75, 225 },
    { -21.65, -36, 18.61, 25 },
}

local firstEyes  = { "eyeOneKilled", "eyeTwoKilled" }
local secondEyes = { "eyeThreeKilled", "eyeFourKilled" }

local function checkRuinousOmen(mob)
    if
        mob:isAlive() and
        mob:getHPP() < mob:getLocalVar("RuinousOmenHPP")
    then
        mob:setLocalVar("RuinousOmenHPP", 0)
        mob:useMobAbility(1911)
    end
end

xi.dynamis.onSpawnNightmareWorm = function(mob)
    xi.dynamis.setNMStats(mob)
    mob:setRoamFlags(xi.roamFlag.WORM)
    -- This is sneaky.  All of our code checks animation sub 0 or 1 for worms.
    -- 4 and 5 have the same functionality, but we want this worm to aggro, so we use 5
    mob:setAnimationSub(5)
    mob:hideName(true)
    mob:setUntargetable(true)
    local newPosition = math.random(1, #wormPositions)
    mob:setPos(wormPositions[newPosition][1], wormPositions[newPosition][2], wormPositions[newPosition][3], wormPositions[newPosition][4])
end

xi.dynamis.onSpawnNightmareAntlion = function(mob)
    xi.dynamis.setNMStats(mob)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    local newPosition = math.random(1, #antlionPositions)
    mob:setPos(antlionPositions[newPosition][1], antlionPositions[newPosition][2], antlionPositions[newPosition][3], antlionPositions[newPosition][4])
end

xi.dynamis.onMobEngagedNightmareWorm = function(mob, target)
    mob:setAnimationSub(0)
    mob:hideName(false)
    mob:setUntargetable(false)
end

xi.dynamis.tavQMSpawnCheck = function(mob, zone, zoneID)
    local timeNPCOne = GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].timeExtensions[1])
    local timeNPCTwo = GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].timeExtensions[2])
    local req = 0
    local reqT = 0

    for _, eye in pairs(firstEyes) do
        if zone:getLocalVar(eye) == 1 then
            req = req + 1
        end
    end

    if req == 1 and timeNPCOne:getStatus() ~= xi.status.NORMAL then
        local chance = math.random(1, 2)
        if chance == 2 then
            timeNPCOne:setStatus(xi.status.NORMAL) -- Make visible
        end
    elseif req == 2 and timeNPCOne:getStatus() ~= xi.status.NORMAL then
        timeNPCOne:setStatus(xi.status.NORMAL) -- Make visible
    end

    for _, eye in pairs(secondEyes) do
        if zone:getLocalVar(eye) == 1 then
            reqT = reqT + 1
        end
    end

    if reqT == 1 and timeNPCTwo:getStatus() ~= xi.status.NORMAL then
        local chance = math.random(1, 2)
        if chance == 2 then
            timeNPCTwo:setStatus(xi.status.NORMAL) -- Make visible
        end
    elseif reqT == 2 and timeNPCTwo:getStatus() ~= xi.status.NORMAL then
        timeNPCTwo:setStatus(xi.status.NORMAL) -- Make visible
    end
end

xi.dynamis.antlionDeath = function(mob)
    local zone = mob:getZone()
    local worm = zone:getLocalVar("wormDeath")
    local mobIndex = zone:getLocalVar(string.format("MobIndex_%s", mob:getID()))

    zone:setLocalVar("antlionDeath", 1)

    if worm == 1 then
        for _, playerEntity in pairs(zone:getPlayers()) do
            if  playerEntity:hasStatusEffect(xi.effect.SJ_RESTRICTION) then -- Does player have SJ restriction?
                playerEntity:delStatusEffect(xi.effect.SJ_RESTRICTION) -- Remove SJ restriction
            end
        end

        zone:setLocalVar("SJUnlock", 1)
    end

    xi.dynamis.addTimeToDynamis(zone, mobIndex) -- Add Time
end

xi.dynamis.wormDeath = function(mob)
    local zone = mob:getZone()
    local antlion = zone:getLocalVar("antlionDeath")

    zone:setLocalVar("wormDeath", 1)

    if antlion == 1 then
        for _, playerEntity in pairs(zone:getPlayers()) do
            if  playerEntity:hasStatusEffect(xi.effect.SJ_RESTRICTION) then -- Does player have SJ restriction?
                playerEntity:delStatusEffect(xi.effect.SJ_RESTRICTION) -- Remove SJ restriction
            end
        end

        zone:setLocalVar("SJUnlock", 1)
    end
end

xi.dynamis.onSpawnUmbralDiabolos = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobType(xi.mobskills.mobType.BATTLEFIELD)
    mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0, true)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

xi.dynamis.onMobEngagedUmbralDiabolos = function(mob, target)
    local zoneID = mob:getZoneID()
    local zone = mob:getZone()

    if zone:getLocalVar("Starlight") == 0 then
        zone:setLocalVar("Starlight", 1)
        for _, member in pairs(zone:getPlayers()) do
            member:changeMusic(0, 239) -- 0 Background Music (Starlight Celebration Music)
            member:changeMusic(1, 239) -- 1 Background Music (Starlight Celebration Music)
        end
    end

    mob:messageText(mob, ID.text.I_AM_A_UNIQUE_ENTITY + zone:getLocalVar("UmbralTextOffset"))
    zone:setLocalVar("UmbralTextOffset", zone:getLocalVar("UmbralTextOffset") + 1)

    local remainingDiabolos = {}
    if zone:getLocalVar("DiabolosClub") == 0 then
        table.insert(remainingDiabolos, 110)
    end

    if zone:getLocalVar("DiabolosHeart") == 0 then
        table.insert(remainingDiabolos, 111)
    end

    if zone:getLocalVar("DiabolosSpade") == 0 then
        table.insert(remainingDiabolos, 112)
    end

    if zone:getLocalVar("DiabolosDiamond") == 0 then
        table.insert(remainingDiabolos, 113)
    end

    xi.dynamis.nmDynamicSpawn(remainingDiabolos[math.random(#remainingDiabolos)], nil, false, zoneID)
    DespawnMob(mob:getID())
end

xi.dynamis.setDiabolosCommonTraits = function(mob)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    -- Some forum posts claim a stun or so would get through unresisted.
    mob:setMod(xi.mod.STUNRES, 95)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.BLINDRES, 100)
    mob:setMod(xi.mod.CURSERES, 100)
    mob:setMod(xi.mod.PARALYZERES, 100)
    mob:setMod(xi.mod.SLOWRES, 95)
    mob:setMod(xi.mod.POISONRES, 95)
    mob:setMobMod(xi.mobMod.SUPERLINK, 5)
    -- MP is a non-issue for these bosses.  No reports of being able to kite them out of MP
    -- And Heart will cast death - costing 666mp
    mob:setMod(xi.mod.REFRESH, 700)
    mob:setLocalVar("RuinousOmenHPP", math.random(35, 65))
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    -- almost all in era videos show diabolos using a tp move on pull
    -- either scripted usage or a regain - hard to tell if its regain since most videos have 18 ppl feeding tp
    mob:setMod(xi.mod.REGAIN, 50)
end

xi.dynamis.onSpawnDiabolosClub = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosClub", mob:getID())
    xi.dynamis.setMegaBossStats(mob)
    xi.dynamis.setDiabolosCommonTraits(mob)
    mob:setLocalVar("ShardSummon1", math.random(50, 75))
    mob:setLocalVar("ShardSummon2", math.random(25, 40))
end

xi.dynamis.onMobFightDiabolosClub = function(mob, mobTarget)
    if
        mob:getLocalVar("ShardSummon1") > 0 and
        mob:isAlive() and
        mob:getHPP() < mob:getLocalVar("ShardSummon1")
    then
        mob:setLocalVar("ShardSummon1", 0)
        local zoneID = mob:getZoneID()
        xi.dynamis.nmDynamicSpawn(252, 110, true, zoneID, mobTarget, mob)
    end

    if
        mob:getLocalVar("ShardSummon2") > 0 and
        mob:isAlive() and
        mob:getHPP() < mob:getLocalVar("ShardSummon2")
    then
        mob:setLocalVar("ShardSummon2", 0)
        local zoneID = mob:getZoneID()
        xi.dynamis.nmDynamicSpawn(252, 110, true, zoneID, mobTarget, mob)
    end

    if mob:getLocalVar("RuinousOmenHPP") > 0 then
        checkRuinousOmen(mob)
    end
end

xi.dynamis.onSpawnDiabolosHeart = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosHeart", mob:getID())
    xi.dynamis.setMegaBossStats(mob)
    xi.dynamis.setDiabolosCommonTraits(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

xi.dynamis.onMobFightDiabolosHeart = function(mob, mobTarget)
    if mob:getLocalVar("RuinousOmenHPP") > 0 then
        checkRuinousOmen(mob)
    end
end

xi.dynamis.onMobMagicPrepareDiabolosHeart = function(mob, mobTarget, spellId)
    if
        mob:getHPP() <= 20
    then
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
        local rand = math.random(1, 3)
        if rand <= 2 then
            return xi.magic.spell.DRAIN
        end
    else
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    end
end

xi.dynamis.onSpawnDiabolosSpade = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosSpade", mob:getID())
    xi.dynamis.setMegaBossStats(mob)
    xi.dynamis.setDiabolosCommonTraits(mob)
end

xi.dynamis.onMobFightDiabolosSpade = function(mob, mobTarget)
    if mob:getLocalVar("RuinousOmenHPP") > 0 then
        checkRuinousOmen(mob)
    end
end

xi.dynamis.onMobWeaponSkillPrepareDiabolosSpade = function(mob, target)
    -- Favors/Spams Nether Blast per some reports
    -- Consider adding a higher percentage of usage
    --[[
    if math.random(1,2) == 2 then
        return 1910
    end
    ]]
end

xi.dynamis.onSpawnDiabolosDiamond = function(mob)
    local zone = mob:getZone()
    zone:setLocalVar("DiabolosDiamond", mob:getID())
    xi.dynamis.setMegaBossStats(mob)
    xi.dynamis.setDiabolosCommonTraits(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

xi.dynamis.onMobFightDiabolosDiamond = function(mob, mobTarget)
    if mob:getLocalVar("RuinousOmenHPP") > 0 then
        checkRuinousOmen(mob)
    end
end

xi.dynamis.onMobWeaponSkillDiabolosDiamond = function(target, mob, skill)
    -- Nightmare was used - the fun begins
    if skill:getID() == 1908 then
        -- Needs more info
        -- Reported to get stronger the more times nightmare happens.
        -- Video evidence showed 5 charms at low HP https://youtu.be/Bvp-T3_U7xA?t=74
        local numDaydreams = 5 --math.min(10 - (mob:getHPP() % 10), 5)
        for i = 0, numDaydreams do
            mob:useMobAbility(1919)
        end
    end
end

xi.dynamis.onSpawnDiabolosShard = function(mob)
    xi.dynamis.setMegaBossStats(mob)
    xi.dynamis.setDiabolosCommonTraits(mob)
end

xi.dynamis.onMobFightDiabolosShard = function(mob, mobTarget)
    mob:useMobAbility(1903)
end

xi.dynamis.onMobWeaponSkillDiabolosShard = function(target, mob, skill)
    mob:setHP(0)
end

-- ToDo
-- Umbrals are suposed to be NPCs

xi.dynamis.mobOnDeathDiabolos = function(mob, player, optParams)
    local zone = mob:getZone()
    if zone:getLocalVar("ProcessMegaBossDeathOnce") > 0 then
        return
    end

    local allDead = true

    local aliveDiabolos = {}
    if zone:getLocalVar("DiabolosClub") > 0 then
        table.insert(aliveDiabolos, GetMobByID(zone:getLocalVar("DiabolosClub")))
    end

    if zone:getLocalVar("DiabolosHeart") > 0 then
        table.insert(aliveDiabolos, GetMobByID(zone:getLocalVar("DiabolosHeart")))
    end

    if zone:getLocalVar("DiabolosSpade") > 0 then
        table.insert(aliveDiabolos, GetMobByID(zone:getLocalVar("DiabolosSpade")))
    end

    if zone:getLocalVar("DiabolosDiamond") > 0 then
        table.insert(aliveDiabolos, GetMobByID(zone:getLocalVar("DiabolosDiamond")))
    end

    for _, v in pairs(aliveDiabolos) do
        if
            v ~= nil and
            v:isAlive()
        then
            allDead = false
        end
    end

    if allDead then
        zone:setLocalVar("ProcessMegaBossDeathOnce", 1)
        -- despawn Umbrals
        for i = 106, 109 do
            local mobID = zone:getLocalVar(string.format("%s", i))
            if mobID > 0 then
                DespawnMob(mobID)
            end
        end

        xi.dynamis.megaBossOnDeath(mob, player, optParams)
    end
end

xi.dynamis.onMobEngagedDiabolos = function(mob, mobTarget)
    mob:setLocalVar("hasEngaged", 1)
end

xi.dynamis.onMobRoamDiabolos = function(mob)
    if mob:getLocalVar("hasEngaged") == 0 then
        return
    end

    local zone = mob:getZone()
    local noHate = true
    local spawnedDiabolos = {}
    if zone:getLocalVar("DiabolosClub") > 0 then
        table.insert(spawnedDiabolos, GetMobByID(zone:getLocalVar("DiabolosClub")))
    end

    if zone:getLocalVar("DiabolosHeart") > 0 then
        table.insert(spawnedDiabolos, GetMobByID(zone:getLocalVar("DiabolosHeart")))
    end

    if zone:getLocalVar("DiabolosSpade") > 0 then
        table.insert(spawnedDiabolos, GetMobByID(zone:getLocalVar("DiabolosSpade")))
    end

    if zone:getLocalVar("DiabolosDiamond") > 0 then
        table.insert(spawnedDiabolos, GetMobByID(zone:getLocalVar("DiabolosDiamond")))
    end

    for _, v in pairs(spawnedDiabolos) do
        if
            v ~= nil and
            v:isEngaged()
        then
            noHate = false
        end
    end

    mob:messageText(mob, ID.text.NOW_I_WILL_JOIN_THEM)

    if noHate then
        for _, v in pairs(spawnedDiabolos) do
            DespawnMob(v:getID())
        end

        for i = 106, 109 do
            local mobID = zone:getLocalVar(string.format("%s", i))
            if mobID > 0 then
                DespawnMob(mobID)
            end
        end
    end
end
