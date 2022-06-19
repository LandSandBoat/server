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
    mob:setMod(xi.mod.REGAIN, 0)
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
        xi.ja.CHARM,
        xi.jsa.SOUL_VOICE,
        xi.jsa.EES_DRAGON,
        xi.jsa.MEIKYO_SHISUI,
        xi.jsa.MIJIN_GAKURE,
        xi.jsa.CALL_WYVERN,
        xi.jsa.ASTRAL_FLOW,
    }

    xi.dynamis.apocLockouts2hr = -- Setup 2hr Lockouts
    {
        {1, 0, "bloodspiller_killed", "MIGHTY_STRIKES"},
        {1, 0, "hamfist_killed", "HUNDRED_FISTS"}, 
        {1, 0, "flesheater_killed", "BENEDICTION"},
        {1, 0, "flamecaller_killed", "MANAFONT"},
        {1, 0, "gosspix_killed", "CHAINSPELL"},
        {1, 0, "bodysnatcher_killed", "PERFECT_DODGE"},
        {1, 0, "ironclad_killed", "INVINCIBLE"},
        {1, 0, "shamblix_killed", "BLOOD_WEAPON"},
        {1, 0, "woodnix_killed", "CHARM"},
        {1, 0, "melomanic_killed", "SOUL_VOICE"},
        {1, 0, "lyncean_killed", "EAGLE_EYE_SHOT"},
        {1, 0, "levinblade_killed", "MEIKYO_SHISUI"},
        {1, 0, "fleetfoot_killed", "MIJIN_GAKURE"},
        {1, 0, "elvaansticker_killed", "CALL_WYVERN"},
        {1, 0, "bibliopage_killed", "ASTRAL_FLOW"},
    }

    xi.dynamis.apocLockouts =
    {
        [1] = {"stihi_killed", 642}, -- Flame Breath
        [2] = {"vishap_killed", 643}, -- Poison Breath
        [3] = {"jurik_killed", 644}, -- Wind Breath
        [4] = {"barong_killed", 645}, -- Body Slam
        [5] = {"tarasca_killed", 646}, -- Heavy Stomp
        [6] = {"alklha_killed", 647}, -- Chaos Blade
        [7] = {"basilic_killed", 648}, -- Petro Eyes
        [8] = {"aitvaras_killed", 649}, -- Voidsong
        [9] = {"koschei_killed", 650}, -- Thornsong
        [10] = {"stollenwurm_killed", 651}, -- Lodesong
    }

    for _, val in pairs(xi.dynamis.apocLockouts2hr) do
        mob:setLocalVar(val[4], val[2])
    end
end

xi.dynamis.onSpawnNoAuto = function(mob)
    xi.dynamis.setNMStats(mob)
    mob:SetAutoAttackEnabled(false)
    mob:addMod(xi.mod.REGAIN, 1250)
end

xi.dynamis.onEngagedApoc = function(mob, target)
    local next2hr = os.time() + math.random(45, 75)
    mob:setLocalVar("next2hrTime", next2hr)     
end

xi.dynamis.onFightApoc = function(mob, target)
    local manafontspells =
    {
        176, -- Firaga III
        181, -- Blizzaga III
        186, -- Aeroga III
        191, -- Stonega III
        196, -- Thundaga III
        201, -- Waterga III
    }
    local chainspellspells =
    {
        361, -- Blindga
        356, -- Paralyga
        362, -- Bindga
        365, -- Breakga
        274, -- Sleepga II
        367, -- Death
    }
    local soulvoicesongs =
    {
        376, -- Horde Lullaby
        373, -- Foe Requiem VI
        397, -- Valor Minuet IV
        420, -- Victory March
        422, -- Carnage Elegy
        463, -- Foe Lullaby
    }

    if mob:getLocalVar("ResetTP") ~= 0 then
        mob:setTP(0)
        mob:setLocalVar("ResetTP", 0)
    end

    -- for _, val in pairs(xi.dynamis.apocLockouts2hr) do
        -- if mob:getZone():getLocalVar(string.format("%s", val[3])) == 1 then
            -- mob:setLocalVar(string.format("%s", val[4]), val[1])
        -- end
    -- end

    while mob:getLocalVar("next2hrTime") <= os.time() do
        if #xi.dynamis.apoc2hrlist > 0 then
            local abilityChoice = math.random(1, #xi.dynamis.apoc2hrlist)
            local next2hr = os.time() + math.random(45, 75)
            mob:useMobAbility(xi.dynamis.apoc2hrlist[abilityChoice])
            table.remove(xi.dynamis.apoc2hrlist, abilityChoice)
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

    if mob:getTP() >= 1000 then
        if #xi.dynamis.apocLockouts > 0 then
            local abilityChoice = math.random(1, #xi.dynamis.apocLockouts)
            if mob:getZone():getLocalVar(xi.dynamis.apocLockouts[abilityChoice][1]) == 0 then
                mob:setLocalVar("ResetTP", 1)
                mob:useMobAbility(xi.dynamis.apocLockouts[abilityChoice][2])
            else
                table.remove(xi.dynamis.apocLockouts, abilityChoice)
            end
        end
    end
end

xi.dynamis.onFightDwagon = function(mob, target)
    if mob:getZone():getLocalVar("MegaBoss_Killed") == 1 then
        mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        mob:setHP(0)
    end
end

xi.dynamis.onRoamDwagon = function(mob)
    if mob:getZone():getLocalVar("MegaBoss_Killed") == 1 then
        mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        mob:setHP(0)
    end
end
