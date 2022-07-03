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
    mob:setRoamFlags(xi.roamFlag.NONE)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 1000) -- See you in Narnia!
    mob:setMobMod(xi.mobMod.ROAM_COOL, 1)
    mob:setBehaviour(xi.behavior.NO_TURN, 1)
    -- Make it so we can reference arbitrary mob
    zone:setLocalVar("Apocalyptic_Beast", mob:getID())
    mob:setLocalVar("Apoc_Beast", 1)
    xi.dynamis.apoc2hrlist = -- Setup fresh 2hr list each time
    {
        {xi.jsa.MIGHTY_STRIKES, "MIGHTY_STRIKES"},
        {xi.jsa.HUNDRED_FISTS, "HUNDRED_FISTS"},
        {xi.jsa.BENEDICTION, "BENEDICTION"},
        {xi.jsa.MANAFONT, "MANAFONT"},
        {xi.jsa.CHAINSPELL, "CHAINSPELL"},
        {xi.jsa.PERFECT_DODGE, "PERFECT_DODGE"},
        {xi.jsa.INVINCIBLE, "INVINCIBLE"},
        {xi.jsa.BLOOD_WEAPON, "BLOOD_WEAPON"},
        {xi.ja.CHARM, "CHARM"},
        {xi.jsa.SOUL_VOICE, "SOUL_VOICE"},
        {xi.jsa.EES_DRAGON, "EAGLE_EYE_SHOT"},
        {xi.jsa.MEIKYO_SHISUI, "MEIKYO_SHISUI"},
        {xi.jsa.MIJIN_GAKURE, "MIJIN_GAKURE"},
        {xi.jsa.CALL_WYVERN, "CALL_WYVERN"},
        {xi.jsa.ASTRAL_FLOW, "ASTRAL_FLOW "},
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

    mob:addListener("WEAPONSKILL_STATE_EXIT", "APOC_WEAPONSKILL_STATE_EXIT", function(mob, target, skill)
        if mob:hasStatusEffect(xi.effect.HYSTERIA) then
            mob:delStatusEffectSilent(xi.effect.HYSTERIA)
        end
    end)

    for _, val in pairs(xi.dynamis.apocLockouts2hr) do
        mob:setLocalVar(val[4], val[2])
    end
end

xi.dynamis.onSpawnNoAuto = function(mob)
    xi.dynamis.setNMStats(mob)
    mob:SetAutoAttackEnabled(false)
    mob:addMod(xi.mod.REGAIN, 1250)
    mob:setRoamFlags(xi.roamFlag.NONE)
    if mob:getFamily() == 87 then
        mob:setBehaviour(xi.behavior.NO_TURN, 1)
    end
end

xi.dynamis.onEngagedApoc = function(mob, target)
    local next2hr = os.time() + math.random(45, 75)
    mob:setLocalVar("next2hrTime", next2hr)     
end

xi.dynamis.onFightApoc = function(mob, target)

    if mob:getLocalVar("ResetTP") ~= 0 then
        mob:setTP(0)
        mob:setLocalVar("ResetTP", 0)
    end

    for _, val in pairs(xi.dynamis.apocLockouts2hr) do
        if mob:getZone():getLocalVar(val[3]) == 1 then
            mob:setLocalVar(val[4], val[1])
        end
    end

    while mob:getLocalVar("next2hrTime") <= os.time() do
        if #xi.dynamis.apoc2hrlist > 0 then
            local abilityChoice = math.random(1, #xi.dynamis.apoc2hrlist)
            local next2hr = os.time() + math.random(45, 75)
            if mob:getLocalVar(xi.dynamis.apoc2hrlist[abilityChoice][2]) == 0 then
                mob:addStatusEffect(xi.effect.HYSTERIA)
            end
            mob:useMobAbility(xi.dynamis.apoc2hrlist[abilityChoice][1])
            table.remove(xi.dynamis.apoc2hrlist, abilityChoice)
            mob:setLocalVar("next2hrTime", next2hr)
        end
    end

    if mob:hasStatusEffect(xi.effect.MANAFONT) and mob:getLocalVar("nextCast") <= os.time() then
        mob:setLocalVar("nextCast", os.time() + 5)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        if mob:getStatus() ~= xi.action.MAGIC_CASTING then
            local manafontspells = {xi.magic.spell.FIRAGA_III, xi.magic.spell.BLIZZAGA_III, xi.magic.spell.AEROGA_III, xi.magic.spell.STONEGA_III, xi.magic.spell.THUNDAGA_III, xi.magic.spell.WATERA_III}
            local spell = manafontspells[math.random(1, #manafontspells)]
            if spell then
                mob:castSpell(spell, target)
            end
        end
    elseif mob:hasStatusEffect(xi.effect.CHAINSPELL) and mob:getLocalVar("nextCast") <= os.time() then
        mob:setLocalVar("nextCast", os.time() + 3)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        if mob:getStatus() ~= xi.action.MAGIC_CASTING then
            local chainspellspells = {xi.magic.spell.BLINDGA, xi.magic.spell.PARALYGA,xi.magic.spell.BINDGA, xi.magic.spell.BREAKGA, xi.magic.spell.SLEEPGA_II, xi.magic.spell.DEATH}
            local spell = chainspellspells[math.random(1,#chainspellspells)]
            if spell then
                mob:castSpell(spell, target)
            end
        end
    elseif mob:hasStatusEffect(xi.effect.SOUL_VOICE) and mob:getLocalVar("nextCast") <= os.time() then
        mob:setLocalVar("nextCast", os.time() + 5)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        if mob:getStatus() ~= xi.action.MAGIC_CASTING then
            local soulvoicesongs = {{xi.magic.spell.HORDE_LULLABY, target},{xi.magic.spell.FOE_REQUIEM_IV, target},{xi.magic.spell.VALOR_MINUET_IV, mob},{xi.magic.spell.VICTORY_MARCH, mob},{xi.magic.spell.CARNAGE_ELEGY, target},{xi.magic.spell.FOE_LULLABY, target}}
            local choice = math.random(1, #soulvoicesongs)
            local song = soulvoicesongs[choice][1]
            local songTarget = soulvoicesongs[choice][2]
            if song then
                mob:castSpell(song, songTarget)
            end
        end
    else
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
    end

    if mob:getTP() >= 1000 then
        if #xi.dynamis.apocLockouts > 0 then
            local abilityChoice = math.random(1, #xi.dynamis.apocLockouts)
            if mob:getZone():getLocalVar(xi.dynamis.apocLockouts[abilityChoice][1]) == 0 then
                local ability = xi.dynamis.apocLockouts[abilityChoice][2]
                mob:setLocalVar("ResetTP", 1)
                mob:useMobAbility(ability)
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
