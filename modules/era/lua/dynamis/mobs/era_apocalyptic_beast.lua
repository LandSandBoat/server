-----------------------------------
-- Apocalyptic Beast Era Module
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("era_apocalyptic_beast")

m:addOverride("xi.zones.Dynamis-Buburimu.mobs.Apocalyptic_Beast.onMobSpawn", function(mob)
    local zone = mob:getZone()
    xi.dynamis.setMegaBossStats(mob)
    -- Set Mods
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.STUNRES, 99)
    mob:setMod(xi.mod.REGAIN, 500)
    mob:setMod(xi.mod.REFRESH, 500)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.BLINDRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 50)
    mob:setMod(xi.mod.SLOWRES, 50)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
    -- Make it so we can reference arbitrary mob
    zone:setLocalVar("Apocalyptic_Beast", mob:getID())
end)

m:addOverride("xi.zones.Dynamis-Buburimu.mobs.Apocalyptic_Beast.onMobEngaged", function(mob, target)
    mob:setLocalVar("last2hrtime", os.time())
    mob:setLocalVar("next2hr", 1)        
end)

m:addOverride("xi.zones.Dynamis-Buburimu.mobs.Apocalyptic_Beast.onMobFight", function(mob, target)
    local abilities2hr =
    {
        [1 ] = xi.jsa.MIGHTY_STRIKES,
        [2 ] = xi.jsa.HUNDRED_FISTS,
        [3 ] = xi.jsa.BENEDICTION,
        [4 ] = xi.jsa.MANAFONT,
        [5 ] = xi.jsa.CHAINSPELL,
        [6 ] = xi.jsa.PERFECT_DODGE,
        [7 ] = xi.jsa.INVINCIBLE,
        [8 ] = xi.jsa.BLOOD_WEAPON,
        [9 ] = xi.jsa.FAMILIAR,
        [10] = xi.jsa.SOUL_VOICE,
        [11] = xi.jsa.EES_DRAGON,
        [12] = xi.jsa.MEIKYO_SHISUI,
        [13] = xi.jsa.MIJIN_GAKURE,
        [14] = xi.jsa.CALL_WYVERN,
        [15] = xi.jsa.ASTRAL_FLOW,
    }
    local manafontspells =
    {
        [1 ] = 176, -- Firaga III
        [2 ] = 181, -- Blizzaga III
        [3 ] = 186, -- Aeroga III
        [4 ] = 191, -- Stonega III
        [5 ] = 196, -- Thundaga III
        [6 ] = 201, -- Waterga III
    }
    local chainspellspells =
    {
        [1 ] = 361, -- Blindga
        [2 ] = 356, -- Paralyga
        [3 ] = 362, -- Bindga
        [4 ] = 365, -- Breakga
        [5 ] = 274, -- Sleepga II
        [6 ] = 367, -- Death
    }
    local soulvoicesongs =
    {
        [1 ] = 376, -- Horde Lullaby
        [2 ] = 373, -- Foe Requiem VI
        [3 ] = 397, -- Valor Minuet IV
        [4 ] = 420, -- Victory March
        [5 ] = 422, -- Carnage Elegy
        [6 ] = 463, -- Foe Lullaby
    }

    while os.time() >= (mob:getLocalVar("last2hrtime") + 45) do
        i = mob:getLocalVar("next2hr")
        mob:useMobAbility(abilities2hr[i])
        mob:setLocalVar("last2hrtime", os.time())
        mob:setLocalVar("next2hr", i + 1)
    end

    if mob:getLocalVar("familiarcharm") == 1 then
        if mob:getLocalVar("next2hr") == 9 and (os.time() >= (mob:getLocalVar("last2hrtime") + 43)) then
            mob:useMobAbility(710)
        end
    end

    if mob:hasStatusEffect(xi.effect.MANAFONT) then
        if mob:getStatus() == xi.action.NONE then
            local spell = manafontspells[math.random(1,6)]
            mob:castSpell(spell)
        end
    end

    if mob:hasStatusEffect(xi.effect.CHAINSPELL) then
        if mob:getStatus() == xi.action.NONE then
            local spell = chainspellspells[math.random(1,6)]
            mob:castSpell(spell)
        end
    end

    if mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
        if mob:getStatus() == xi.action.NONE then
            local song = soulvoicesongs[math.random(1,6)]
            mob:castSpell(song)
        end
    end
end)

m:addOverride("xi.zones.Dynamis-Buburimu.mobs.Apocalyptic_Beast.onMobRoam", function(mob) xi.dynamis.mobOnRoam(mob) end)
m:addOverride("xi.zones.Dynamis-Buburimu.mobs.Apocalyptic_Beast.onMobRoamAction", function(mob) xi.dynamis.mobOnRoamAction(mob) end)

m:addOverride("xi.zones.Dynamis-Buburimu.mobs.Apocalyptic_Beast.onMobWeaponskillPrepare", function(mob, target)
    local zone = mob:getZone()
    local voidsong = 10
    local chaosblade = 10
    local bodyslam = 10
    local petroeyes = 10
    local windbreath = 10
    local flamebreath = 10
    local lodesong = 10
    local heavystomp = 10
    local poisonbreath = 10
    local thornsong = 10
    local charm = 10

    -- Set Probabilities of Each Skill Based on Dragon Kill Status
    if not GetMobByID(zone:getLocalVar("Aitvaras")):isAlive() then
        voidsong = 0
    end
    if not GetMobByID(zone:getLocalVar("Alklha")):isAlive() then
        chaosblade = 0
    end
    if not GetMobByID(zone:getLocalVar("Barong")):isAlive() then
        bodyslam = 0
    end
    if not GetMobByID(zone:getLocalVar("Basillic")):isAlive() then
        petroeyes = 0
    end
    if not GetMobByID(zone:getLocalVar("Jurik")):isAlive() then
        windbreath = 0
    end
    if not GetMobByID(zone:getLocalVar("Koschei")):isAlive() then
        thornsong = 0
    end
    if not GetMobByID(zone:getLocalVar("Stihi")):isAlive() then
        flamebreath = 0
    end
    if not GetMobByID(zone:getLocalVar("Stollenwurm")):isAlive() then
        lodesong = 0
    end
    if not GetMobByID(zone:getLocalVar("Tarasca")):isAlive() then
        heavystomp = 0
    end
    if not GetMobByID(zone:getLocalVar("Vishap")):isAlive() then
        poisonbreath = 0
    end
    if mob:getLocalVar("familiarcharm") == 0 then
        charm = 0
    end

    local totalchance = voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath + charm
    local randomchance = math.random(1, totalchance)

    -- Choose Skill
    if randomchance >= (totalchance - voidsong) then
        return 649 -- Voidsong
    elseif randomchance >= (totalchance - (voidsong + chaosblade)) then
        return 647 -- Chaos Blade
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam)) then
        return 645 -- Body Slam
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes)) then
        return 648 -- Petro Eyes
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath)) then
        return 644 -- Wind Breath
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong)) then
        return 650 -- Thornsong
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath)) then
        return 642 -- Flame Breath
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong)) then
        return 651 -- Lodesong
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp)) then
        return 646 -- Heavy Stomp
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath)) then
        return 643 -- Poison Breath
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath + charm)) then
        return 710 -- Charm
    else
        return 0
    end
end)

return m