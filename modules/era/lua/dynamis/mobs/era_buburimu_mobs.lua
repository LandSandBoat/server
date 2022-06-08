-----------------------------------
--  Buburimu Mobs Era Module  --
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

xi.dynamis.onSpawnApoc = function(mob)
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
    mob:setMobMod(xi.mobMod.SPAWN_LEASH, 300) -- See you in Narnia!
    -- Make it so we can reference arbitrary mob
    zone:setLocalVar("Apocalyptic_Beast", mob:getID())
    mob:setLocalVar("Apoc_Beast", 1)
    xi.dynamis.apoc2hrlist = -- Setup fresh 2hr list each time
    {
        xi.jsa.MIGHTY_STRIKES,
        xi.jsa.HUNDRED_FISTS,
        xi.jsa.BENEDICTION,
        xi.jsa.MANAFONT,
        xi.jsa.CHAINSPELL,
        xi.jsa.PERFECT_DODGE,
        xi.jsa.INVINCIBLE,
        xi.jsa.BLOOD_WEAPON,
        710, -- Charm used in place of Familiar
        xi.jsa.SOUL_VOICE,
        xi.jsa.EES_DRAGON,
        xi.jsa.MEIKYO_SHISUI,
        xi.jsa.MIJIN_GAKURE,
        xi.jsa.CALL_WYVERN,
        xi.jsa.ASTRAL_FLOW,
    }

    xi.dynamis.apocLockouts2hr = -- Setup 2hr Lockouts
    {
        ["MIGHTY_STRIKES"] = {1, 0, "Qu'Pho Bloodspiller"},
        ["HUNDRED_FISTS"] = {1, 0, "Hamfist Gukhbuk"}, 
        ["BENEDICTION"] = {1, 0, "Gi'Bhe Fleshfeaster"},
        ["MANAFONT"] = {1, 0, "Flamecaller Zoeqdoq"},
        ["CHAINSPELL"] = {1, 0, "Gosspix Blabberlips"},
        ["PERFECT_DODGE"] = {1, 0, "Va'Rhu Bodysnatcher"},
        ["INVINCIBLE"] = {1, 0, "Te'Zha Ironclad"},
        ["BLOOD_WEAPON"] = {1, 0, "Shamblix Rottenheart"},
        ["CHARM"] = {1, 0, "Woodnix Shrillwhistle"},
        ["SOUL_VOICE"] = {1, 0, "Ree Nata the Melomanic"},
        ["EAGLE_EYE_SHOT"] = {1, 0, "Lyncean Juwgneg"},
        ["MEIKYO_SHISUI"] = {1, 0, "Koo Rahi the Levinblade"},
        ["MIJIN_GAKURE"] = {1, 0, "Doo Peku the Fleetfoot"},
        ["CALL_WYVERN"] = {1, 0, "Elvaansticker Bxafraff"},
        ["ASTRAL_FLOW"] = {1, 0, "Baa Dava the Bibliophage"},
    }

    xi.dynamis.apocLockouts =
    {
        ["Stihi"] = 642, -- Flame Breath
        ["Vishap"] = 643, -- Poison Breath
        ["Jurik"] = 644, -- Wind Breath
        ["Barong"] = 645, -- Body Slam
        ["Tarasca"] = 646, -- Heavy Stomp
        ["Alklha"] = 647, -- Chaos Blade
        ["Basillic"] = 648, -- Petro Eyes
        ["Aitvaras"] = 649, -- Voidsong
        ["Koschei"] = 650, -- Thornsong
        ["Stollenwurm"] = 651, -- Lodesong
    }

    xi.dynamis.apocWeaponskills =
    {
        642, -- Flame Breath
        643, -- Poison Breath
        644, -- Wind Breath
        645, -- Body Slam
        646, -- Heavy Stomp
        647, -- Chaos Blade
        648, -- Petro Eyes
        649, -- Voidsong
        650, -- Thornsong
        651, -- Lodesong
    }

    for var, val in pairs(xi.dynamis.apocLockouts2hr) do
        mob:setLocalVar(var, val[1])
    end
end

xi.dynamis.onSpawnNoAuto = function(mob)
    xi.dynamis.setNMStats(mob)
    mob:SetAutoAttackEnabled(false)
    mob:addMod(xi.mod.REGAIN, 1250)
end

xi.dynamis.onEngagedApoc = function(mob, target)
    local next2hr = os.time + math.random(45, 75)
    mob:setLocalVar("next2hrTime", next2hr)     
end

xi.dynamis.onFightApoc = function(mob, target)
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

    for var, val in pairs(xi.dynamis.apocLockouts2hr) do
        if not mob:getZone():getLocalVar(string.format("%s", val[3])):isAlive() then
            mob:setLocalVar(string.format("%s", var), val[2])
            table.remove(xi.dynamis.apocLockouts2hr, var)
        end
    end

    while os.time() >= mob:getLocalVar("next2hrTime") do
        local length2hrTable = #xi.dynamis.apoc2hrlist
        if length2hrTable ~= 0 then
            local choice = math.random(1, length2hrTable)
            local next2hr = os.time + math.random(45, 75)
            mob:useMobAbility(xi.dynamis.apoc2hrlist[choice])
            table.remove(xi.dynamis.apoc2hrlist, choice)
            mob:setLocalVar("next2hrTime", next2hr)
        end
    end

    if mob:hasStatusEffect(xi.effect.MANAFONT) then
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        if mob:getStatus() == xi.action.NONE then
            local spell = manafontspells[math.random(1,6)]
            mob:castSpell(spell)
        end
    elseif mob:hasStatusEffect(xi.effect.CHAINSPELL) then
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        if mob:getStatus() == xi.action.NONE then
            local spell = chainspellspells[math.random(1,6)]
            mob:castSpell(spell)
        end
    elseif mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        if mob:getStatus() == xi.action.NONE then
            local song = soulvoicesongs[math.random(1,6)]
            mob:castSpell(song)
        end
    else
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
    end
end

xi.dynamis.onWeaponskillPrepApoc = function(mob, target)
    for dwagon, skill in pairs(xi.dynamis.apocWeaponskills) do -- Locks out specific abilities
        if not GetMobByID(zone:getLocalVar(dwagon)):isAlive() then -- If target is not alive then clean
            table.remove(xi.dynamis.apocWeaponskills, skill) -- Clean Weaponskills Table For Lockouts
            table.remove(xi.dynamis.apocLockouts, dwagon) -- Clean Lockouts Table to Reduce Compute
        end
    end

    local tableLength = #xi.dynamis.apocWeaponskills
    if tableLength ~= 0 then
        return xi.dynamis.apocWeaponskills[math.random(1, tableLength)]
    else
        return 0
    end
end

xi.dynamis.onDeathApoc = function(mob, player, isKiller)
    for dwagon, skill in pairs(xi.dynamis.apocLockouts) do -- Check a cleaned table to see what is alive.
        if GetMobByID(zone:getLocalVar(string.format("%s", dwagon)):isAlive()) then -- Second alive check to be sure.
            DespawnMob(zone:getLocalVar(string.format("%s", dwagon))) -- Despawn extra dwagon.
        end
    end

    xi.dynamis.megaBossOnDeath(mob, player, isKiller)
end


