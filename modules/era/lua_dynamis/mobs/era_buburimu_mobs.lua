-----------------------------------
--  Buburimu Mobs Era Module  --
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

local function apocRemoveAdditionalEffects(mob)
    local statusEffects =
    {
        xi.effect.MIGHTY_STRIKES,
        xi.effect.HUNDRED_FISTS,
        xi.effect.MANAFONT,
        xi.effect.CHAINSPELL,
        xi.effect.PERFECT_DODGE,
        xi.effect.INVINCIBLE,
        xi.effect.BLOOD_WEAPON,
        xi.effect.SOUL_VOICE,
        xi.effect.MEIKYO_SHISUI,
        xi.effect.ASTRAL_FLOW,
    }

    for _, effect in pairs(statusEffects) do
        if mob:hasStatusEffect(effect) then
            mob:delStatusEffect(effect)
        end
    end

    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:clearActionQueue()
end

xi.dynamis.onSpawnApoc = function(mob)
    local zone = mob:getZone()
    xi.dynamis.setMegaBossStats(mob)
    -- Set Mods
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.STUNRES, 80)
    mob:setMod(xi.mod.REFRESH, 500)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.BLINDRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 50)
    mob:setMod(xi.mod.SLOWRES, 50)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.MACC, 200)
    mob:setMod(xi.mod.MATT, 50)
    mob:setMod(xi.mod.FASTCAST, 5)
    mob:setRoamFlags(xi.roamFlag.NONE)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 1000) -- See you in Narnia!
    mob:setMobMod(xi.mobMod.ROAM_COOL, 1)
    mob:setBehaviour(xi.behavior.NO_TURN, 1)
    -- Make it so we can reference arbitrary mob
    zone:setLocalVar("Apocalyptic_Beast", mob:getID())
    mob:setLocalVar("Apoc_Beast", 1)
    xi.dynamis.apoc2hrlist = -- Setup fresh 2hr list each time
    {
        {xi.jsa.MIGHTY_STRIKES, "MIGHTY_STRIKES", "self"},
        {xi.jsa.HUNDRED_FISTS, "HUNDRED_FISTS", "self"},
        {xi.jsa.BENEDICTION, "BENEDICTION", "self"},
        {xi.jsa.MANAFONT, "MANAFONT", "self"},
        {xi.jsa.CHAINSPELL, "CHAINSPELL", "self"},
        {xi.jsa.PERFECT_DODGE, "PERFECT_DODGE", "self"},
        {xi.jsa.INVINCIBLE, "INVINCIBLE", "self"},
        {xi.jsa.BLOOD_WEAPON, "BLOOD_WEAPON", "self"},
        {710, "CHARM", "target"},
        {xi.jsa.SOUL_VOICE, "SOUL_VOICE", "self"},
        {xi.jsa.EES_GOBLIN, "EAGLE_EYE_SHOT", "target"},
        {xi.jsa.MEIKYO_SHISUI, "MEIKYO_SHISUI", "self"},
        {xi.jsa.MIJIN_GAKURE, "MIJIN_GAKURE", "self"},
        {xi.jsa.CALL_WYVERN, "CALL_WYVERN", "self"},
        {xi.jsa.ASTRAL_FLOW, "ASTRAL_FLOW", "self"},
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
    mob:setAutoAttackEnabled(false)
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

    if mob:getLocalVar("next2hrTime") <= os.time() and #xi.dynamis.apoc2hrlist > 0 then
        local abilityChoice = math.random(1, #xi.dynamis.apoc2hrlist)
        local next2hr = os.time() + math.random(45, 75)
        local target2 = mob

        if mob:getLocalVar(xi.dynamis.apoc2hrlist[abilityChoice][2]) == 1 then
            mob:addStatusEffect(xi.effect.HYSTERIA, 1, 3, 5)
        end

        if xi.dynamis.apoc2hrlist[abilityChoice][3] and xi.dynamis.apoc2hrlist[abilityChoice][3] == "target" then
            target2 = target
        end

        apocRemoveAdditionalEffects(mob)
        mob:useMobAbility(xi.dynamis.apoc2hrlist[abilityChoice][1], target2)
        table.remove(xi.dynamis.apoc2hrlist, abilityChoice)

        mob:setLocalVar("next2hrTime", next2hr)
    end

    if
        (mob:hasStatusEffect(xi.effect.MANAFONT) or
        mob:hasStatusEffect(xi.effect.CHAINSPELL) or
        mob:hasStatusEffect(xi.effect.SOUL_VOICE)) and
        mob:getLocalVar("nextCast") <= os.time()
    then
        mob:setLocalVar("nextCast", os.time() + 4)
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)
        local spell = nil

        if mob:getStatus() ~= xi.action.MAGIC_CASTING then
            if mob:hasStatusEffect(xi.effect.MANAFONT) then
                if mob:hasStatusEffect(xi.effect.CHAINSPELL) then
                    mob:delStatusEffectSilent(xi.effect.CHAINSPELL)
                end

                if mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
                    mob:delStatusEffect(xi.effect.SOUL_VOICE)
                end

                local manafontspells = {xi.magic.spell.FIRAGA_III, xi.magic.spell.BLIZZAGA_III, xi.magic.spell.AEROGA_III, xi.magic.spell.STONEGA_III, xi.magic.spell.THUNDAGA_III, xi.magic.spell.WATERA_III}
                spell = manafontspells[math.random(1, #manafontspells)]
            elseif mob:hasStatusEffect(xi.effect.CHAINSPELL) then
                local chainspellspells = {xi.magic.spell.BLINDGA, xi.magic.spell.PARALYGA,xi.magic.spell.BINDGA, xi.magic.spell.BREAKGA, xi.magic.spell.SLEEPGA_II, xi.magic.spell.DEATH}
                spell = chainspellspells[math.random(1,#chainspellspells)]
            elseif mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
                local buffsongs = {{xi.magic.spell.VALOR_MINUET_IV, mob}, {xi.magic.spell.VICTORY_MARCH}}
                local soulvoicesongs = {{xi.magic.spell.HORDE_LULLABY, target}, {xi.magic.spell.FOE_REQUIEM_IV, target}, {xi.magic.spell.CARNAGE_ELEGY, target}, {xi.magic.spell.FOE_LULLABY, target}}
                local buffEnfeeb = math.random(1, 4)
                local choice = 0
                if buffEnfeeb == 1 then
                    choice = math.random(1, #buffsongs)
                    spell = buffsongs[choice][1]
                    target = buffsongs[choice][2]
                else
                    choice = math.random(1, #soulvoicesongs)
                    spell = soulvoicesongs[choice][1]
                    target = soulvoicesongs[choice][2]
                end
            end

            if spell then
                mob:castSpell(spell, target)
            end
        end
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

xi.dynamis.onFightDragon = function(mob, target)
    if mob:getZone():getLocalVar("MegaBoss_Killed") == 1 then
        mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        DespawnMob(mob:getID())
    end
end

xi.dynamis.onRoamDragon = function(mob)
    if mob:getZone():getLocalVar("MegaBoss_Killed") == 1 then
        mob:setMobMod(xi.mobMod.NO_DROPS, 1)
        DespawnMob(mob:getID())
    end
end
