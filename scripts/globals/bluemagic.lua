require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")

-- The TP modifier
TPMOD_NONE = 0
TPMOD_CRITICAL = 1
TPMOD_DAMAGE = 2
TPMOD_ACC = 3
TPMOD_ATTACK = 4
TPMOD_DURATION = 5

INT_BASED = 1
CHR_BASED = 2
MND_BASED = 3

-----------------------------------
-- Utility functions below
-----------------------------------

-- Get alpha (level-dependent multiplier on WSC)
local function blueGetAlpha(level)
    if level < 61 then
        return math.ceil(100 - (level / 6)) / 100
    elseif level <= 75 then
        return math.ceil(100 - (level - 40) / 2) / 100
    elseif level <= 99 then
        return 0.83
    end
<<<<<<< refs/remotes/upstream/base

    return alpha
=======
>>>>>>> Azure Lore, potency/correlation merits, correlation in general, clean up, physical about done
end

-- Get WSC
local function blueGetWSC(attacker, params)
    local wsc = (attacker:getStat(xi.mod.STR) * params.str_wsc + attacker:getStat(xi.mod.DEX) * params.dex_wsc +
        attacker:getStat(xi.mod.VIT) * params.vit_wsc + attacker:getStat(xi.mod.AGI) * params.agi_wsc +
        attacker:getStat(xi.mod.INT) * params.int_wsc + attacker:getStat(xi.mod.MND) * params.mnd_wsc +
        attacker:getStat(xi.mod.CHR) * params.chr_wsc) * blueGetAlpha(attacker:getMainLvl())
    return wsc
end

-- Get cRatio
local function blueGetcRatio(ratio, atk_lvl, def_lvl)

    -- Apply level penalty
    local levelcor = 0
    if atk_lvl < def_lvl then
        levelcor = 0.05 * (def_lvl - atk_lvl)
    end

    ratio = ratio - levelcor

    -- Clamp
    ratio = utils.clamp(ratio,0,2)

    -- Obtain cRatiomin
    local cratiomin = 0
    if ratio < 1.25 then
        cratiomin = 1.2 * ratio - 0.5
    elseif ratio >= 1.25 and ratio <= 1.5 then
        cratiomin = 1
    elseif ratio > 1.5 and ratio <= 2 then
        cratiomin = 1.2 * ratio - 0.8
    end

    -- Obtain cRatiomax
    local cratiomax = 0
    if ratio < 0.5 then
        cratiomax = 0.4 + 1.2 * ratio
    elseif ratio <= 0.833 and ratio >= 0.5 then
        cratiomax = 1
    elseif ratio <= 2 and ratio > 0.833 then
        cratiomax = 1.2 * ratio
    end

    local cratio = {}
    if cratiomin < 0 then
        cratiomin = 0
    end

<<<<<<< refs/remotes/upstream/base
=======
    -- Return data
>>>>>>> Azure Lore, potency/correlation merits, correlation in general, clean up, physical about done
    cratio[1] = cratiomin
    cratio[2] = cratiomax
    return cratio

end

-- Get the fTP multiplier (by applying 2 straight lines between ftp0-ftp1500 and ftp1500-ftp3000)
local function blueGetfTP(tp, ftp0, ftp1500, ftp3000)
    tp = utils.clamp(tp,0,3000)
    if tp >= 0 and tp < 1500 then
        return ftp0 + ((ftp1500 - ftp0) * (tp / 1500))
    elseif tp >= 1500 then
        return ftp1500 + ((ftp3000 - ftp1500) * ((tp - 1500) / 1500))
    else -- unreachable
        return 1
    end
<<<<<<< refs/remotes/upstream/base

    return 1 -- no ftp mod
=======
>>>>>>> Azure Lore, potency/correlation merits, correlation in general, clean up, physical about done
end

-- Get fSTR
local function blueGetfSTR(dSTR)
    local fSTR2 = nil
    if dSTR >= 12 then
        fSTR2 = (dSTR + 4) / 2
    elseif dSTR >= 6 then
        fSTR2 = (dSTR + 6) / 2
    elseif dSTR >= 1 then
        fSTR2 = (dSTR + 7) / 2
    elseif dSTR >= -2 then
        fSTR2 = (dSTR + 8) / 2
    elseif dSTR >= -7 then
        fSTR2 = (dSTR + 9) / 2
    elseif dSTR >= -15 then
        fSTR2 = (dSTR + 10) / 2
    elseif dSTR >= -21 then
        fSTR2 = (dSTR + 12) / 2
    else
        fSTR2 = (dSTR + 13) / 2
    end
    return fSTR2
end

-- Get hitrate
local function blueGetHitrate(attacker, target)
    local acc = attacker:getACC() + attacker:getMerit(xi.merit.PHYSICAL_POTENCY)
    local eva = target:getEVA()
    acc = acc + ((attacker:getMainLvl() - target:getMainLvl()) * 4)

<<<<<<< refs/remotes/upstream/base
    if attacker:getMainLvl() > target:getMainLvl() then -- acc bonus!
        acc = acc + ((attacker:getMainLvl() - target:getMainLvl()) * 4)
    elseif attacker:getMainLvl() < target:getMainLvl() then -- acc penalty :(
        acc = acc - ((target:getMainLvl() - attacker:getMainLvl()) * 4)
    end

    local hitdiff = 0
    local hitrate = 75
    if acc > eva then
        hitdiff = (acc - eva) / 2
    end

    if eva > acc then
        hitdiff = (-1 * (eva - acc)) / 2
    end

    hitrate = hitrate + hitdiff
=======
    local hitrate = 75 + (acc - eva) / 2
>>>>>>> Azure Lore, potency/correlation merits, correlation in general, clean up, physical about done
    hitrate = hitrate / 100
    hitrate = utils.clamp(hitrate, 0.2, 0.95)

<<<<<<< refs/remotes/upstream/base
<<<<<<< refs/remotes/upstream/base
    -- Applying hitrate caps
    if capHitRate then -- this isn't capped for when acc varies with tp, as more penalties are due
        if hitrate > 0.95 then
            hitrate = 0.95
        end

        if hitrate < 0.2 then
            hitrate = 0.2
        end
    end
<<<<<<< refs/remotes/upstream/base
=======
    attacker:PrintToPlayer(string.format("Hitrate %s", hitrate))
>>>>>>> Temp save
=======
    --attacker:PrintToPlayer(string.format("Hitrate %s", hitrate))
>>>>>>> Azure Lore, potency/correlation merits, correlation in general, clean up, physical about done

=======
>>>>>>> Renamed BLU functions, added drain function (yet to rewire), used existing systemStrength table
    return hitrate
end

-- Get the effect of ecosystem correlation
local function blueGetCorrelation(spellEcosystem, monsterEcosystem, merits)
    local effect = utils.getSystemStrengthBonus(spellEcosystem, monsterEcosystem)
    effect = effect * 0.25
    if effect > 0 then -- merits don't impose a penalty, only a benefit in case of strength
        effect = effect + 0.001 * merits
    end
    return effect
end

-- Get the damage for a physical Blue Magic spell
function blueDoPhysicalSpell(caster, target, spell, params)

    -----------------------
    -- Get final D value --
    -----------------------

    -- Initial D value
    local initialD = math.floor(caster:getSkillLevel(xi.skill.BLUE_MAGIC) * 0.11) * 2 + 3
    initialD = utils.clamp(initialD,0,params.duppercap)

    -- fSTR
    local fStr = blueGetfSTR(caster:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT))
    if fStr > 22 then
        if params.ignorefstrcap == nil then -- Smite of Rage / Grand Slam don't have this cap applied
            fStr = 22
        end
    end

    -- Multiplier, bonus WSC
    local multiplier = 1
    local bonusWSC = 0

    -- BLU AF3 bonus (triples the base WSC when it procs)
    if caster:getMod(xi.mod.AUGMENT_BLU_MAGIC) > math.random(0, 99) then
        bonusWSC = 2
    end

    -- Chain Affinity -- TODO: add "Damage/Accuracy/Critical Hit Chance varies with TP"
    if caster:getStatusEffect(xi.effect.CHAIN_AFFINITY) then
        local tp = caster:getTP() + caster:getMerit(xi.merit.ENCHAINMENT) -- Total TP available
        tp = utils.clamp(tp,0,3000)
        multiplier = blueGetfTP(tp, params.multiplier, params.tp150, params.tp300)
        bonusWSC = bonusWSC + 1 -- Chain Affinity doubles base WSC
    end

    -- WSC
    local wsc = blueGetWSC(caster, params)
    wsc = wsc + (wsc * bonusWSC) -- Bonus WSC from AF3/CA

    -- Monster correlation
    local correlationMultiplier = blueGetCorrelation(params.ecosystem, target:getSystem(), caster:getMerit(xi.merit.MONSTER_CORRELATION))

    -- Azure Lore
    if caster:getStatusEffect(xi.effect.AZURE_LORE) then
        multiplier = params.azuretp
    end

    -- Final D
    local finalD = math.floor(initialD + fStr + wsc)

    ----------------------------------------------
    -- Get the possible pDIF range and hit rate --
    ----------------------------------------------

    if params.offcratiomod == nil then -- For all spells except Cannonball, which uses a DEF mod
        params.offcratiomod = caster:getStat(xi.mod.ATT)
    end

    local cratio = blueGetcRatio(params.offcratiomod / target:getStat(xi.mod.DEF), caster:getMainLvl(), target:getMainLvl())
    local hitrate = blueGetHitrate(caster, target)

    -------------------------
    -- Perform the attacks --
    -------------------------

    local hitsdone = 0
    local hitslanded = 0
    local finaldmg = 0

    while hitsdone < params.numhits do
        local chance = math.random()
        if chance <= hitrate then -- it hit
            -- TODO: Check for shadow absorbs. Right now the whole spell will be absorbed by one shadow before it even gets here.

            -- Generate a random pDIF between min and max
            local pdif = math.random(cratio[1] * 1000, cratio[2] * 1000)
            pdif = pdif / 1000

            -- Add it to our final damage
            if hitsdone == 0 then
                finaldmg = finaldmg + (finalD * (multiplier + correlationMultiplier) * pdif) -- first hit gets full multiplier
            else
                finaldmg = finaldmg + (finalD * (1 + correlationMultiplier) * pdif)
            end

            hitslanded = hitslanded + 1

            -- increment target's TP (100TP per hit landed)
            if finaldmg > 0 then
                target:addTP(100)
            end
        end

        hitsdone = hitsdone + 1
    end

    return finaldmg
end

-- Get the damage for a magical Blue Magic spell
function blueDoMagicalSpell(caster, target, spell, params, statMod)

    -- how do mobs weak to element get more dmg from that? (getElementalDamageReduction in addBonuses, DONE)

    local D = caster:getMainLvl() + 2

    if D > params.duppercap then
        D = params.duppercap
    end

    local st = blueGetWSC(caster, params) -- According to Wiki ST is the same as WSC, essentially Blue mage spells that are magical use the dmg formula of Magical type Weapon skills

    if caster:hasStatusEffect(xi.effect.BURST_AFFINITY) then
        st = st * 2
    end

    local statBonus = 0
    local dStat = 0 -- Please make sure to add an additional stat check if there is to be a spell that uses neither INT, MND, or CHR. None currently exist.
    if statMod == INT_BASED then -- Stat mod is INT
        dStat = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
        statBonus = dStat * params.tMultiplier
    elseif statMod == CHR_BASED then -- Stat mod is CHR
        dStat = caster:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR)
        statBonus = dStat * params.tMultiplier
    elseif statMod == MND_BASED then -- Stat mod is MND
        dStat = caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)
        statBonus = dStat * params.tMultiplier
    end

    D = ((D + st) * params.multiplier) + statBonus

    -- At this point according to wiki we apply standard magic attack calculations

    local magicAttack = 1.0
    local multTargetReduction = 1.0 -- TODO: Make this dynamically change, temp static till implemented.
    magicAttack = math.floor(D * multTargetReduction)

    local rparams = {}
    rparams.diff = dStat
    rparams.skillType = xi.skill.BLUE_MAGIC
    magicAttack = math.floor(magicAttack * applyResistance(caster, target, spell, rparams))

    local dmg = math.floor(addBonuses(caster, spell, target, magicAttack)) -- mab/mdb/weather/day

    caster:delStatusEffectSilent(xi.effect.BURST_AFFINITY)



    return dmg
end

-- Perform a draining magical Blue Magic spell
function blueDoDrainSpell(caster, target, spell, params, softCap, mpDrain)

    -- determine base damage
    local dmg = params.dmgMultiplier * math.floor(caster:getSkillLevel(xi.skill.BLUE_MAGIC) * 0.11)
    if softCap > 0 then dmg = utils.clamp(dmg,0,softCap) end
    local resist = applyResistance(caster, target, spell, params)
    dmg = dmg * resist
    dmg = addBonuses(caster, spell, target, dmg)
    dmg = adjustForTarget(target, dmg, spell:getElement())

    -- limit damage
    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        -- only drain what the mob has
        if mpDrain then
            dmg = dmg * xi.settings.main.BLUE_POWER
            dmg = utils.clamp(dmg,0,target:getMP())
            target:delMP(dmg)
            caster:addMP(dmg)
        else
            dmg = utils.clamp(dmg,0,target:getHP())
            dmg = blueFinalizeDamage(caster, target, spell, dmg, params)
            caster:addHP(dmg)
        end
    end

    return dmg

end

-- Get the damage and resistance for a breath Blue Magic spell
function blueDoBreathSpell(caster, target, spell, params, isConal)

    local results = {}
    results[1] = 0 -- damage
    results[2] = 0 -- resistance (used in spell to determine added effect resistance)

    -- Initial damage
    local dmg = (caster:getHP() / params.hpMod)
    if params.lvlMod > 0 then dmg = dmg + (caster:getMainLvl() / params.lvlMod) end

    -- Conal breath spells get reduced damage (or no damage) further away from centerline
    if isConal then

        -- Conal check (90° cone)
        local isInCone = 0
        if target:isInfront(caster,64) then isInCone = 1 end
        dmg = dmg * isInCone

        -- Less damage when the target is more to the side of the caster
        local angle = caster:getFacingAngle(target)
        local angleDmgMultiplier = (100 - (3 * math.max(math.abs(angle) - 16, 0))) / 100
            -- 100% damage when inside a cone in front (45° cone, 32/256)
            -- 50% damage when monster is to your side (90° cone, 64/256)
            -- linear function: from 22° to 45° > 100% to 50% dmg
            -- caster:PrintToPlayer(string.format("angle " .. angle * 1.4117 .. "   mult " .. angleDmgMultiplier))
        dmg = dmg * angleDmgMultiplier

    end

    -- Monster correlation
    local correlationMultiplier = blueGetCorrelation(params.ecosystem, target:getSystem(), caster:getMerit(xi.merit.MONSTER_CORRELATION))
    dmg = dmg * (1 + correlationMultiplier)

    -- Monster elemental adjustments
    local mobEleAdjustments = getElementalDamageReduction(target, spell:getElement())
    dmg = dmg * mobEleAdjustments

    -- Modifiers
    dmg = dmg * (1 + (caster:getMod(xi.mod.BREATH_DMG_DEALT) / 100))

    -- Resistance
    local resistance = applyResistance(caster, target, spell, params)
    dmg = math.floor(dmg * resistance)

    -- Final damage
    dmg = target:breathDmgTaken(dmg)

    results[1] = dmg
    results[2] = resistance
    return results

end


-- Finalize HP damage after a spell
function blueFinalizeDamage(caster, target, spell, dmg, params)

    if dmg < 0 then dmg = 0 end
    dmg = dmg * xi.settings.main.BLUE_POWER
    local attackType = params.attackType or xi.attackType.NONE
    local damageType = params.damageType or xi.damageType.NONE

    -- handle MDT, One For All, Liement
    if attackType == xi.attackType.MAGICAL then
        local targetMagicDamageAdjustment = xi.spells.damage.calculateTMDA(caster, target, damageType) -- Apply checks for Liement, MDT/MDTII/DT
        dmg = math.floor(dmg * targetMagicDamageAdjustment)
        if dmg < 0 then
            target:takeSpellDamage(caster, spell, dmg, attackType, damageType)
            -- TODO: verify Afflatus/enmity from absorb?
            return dmg
        end

        dmg = utils.oneforall(target, dmg)
    end

    -- handle Phalanx
    if dmg > 0 then dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999) end

    -- handle stoneskin
    dmg = utils.stoneskin(target, dmg)

    target:takeSpellDamage(caster, spell, dmg, attackType, damageType)
    target:updateEnmityFromDamage(caster, dmg)
    target:handleAfflatusMiseryDamage(dmg)

    return dmg
end

-- Get the duration of an enhancing Blue Magic spell
function blueGetDurationWithDiffusion(caster, duration)

    if caster:hasStatusEffect(xi.effect.DIFFUSION) then
        local merits = caster:getMerit(xi.merit.DIFFUSION)
        if merits > 0 then -- each merit after the first increases duration by 5%
            duration = duration + (duration / 100) * (merits - 5)
        end
        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    return duration
end

-- Perform an enfeebling Blue Magic spell
function blueDoEnfeeblingSpell(caster, target, spell, params, power, tick, duration, resistThreshold, isGaze, isConal)

    -- INT and Blue Magic skill are the default resistance modifiers
    if params.attribute == nil then params.attribute = xi.mod.INT end
    if params.skillType == nil then params.skillType = xi.skill.BLUE_MAGIC end
    local resist = applyResistanceEffect(caster, target, spell, params)

    -- If unresisted
    if resist >= resistThreshold then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

        -- If this is a conal move, target needs to be in front of caster
        if not isConal or (isConal and target:isInfront(caster,64)) then -- 90° cone

            -- If this is a gaze move, entities need to face each other
            if not isGaze or (isGaze and target:isFacing(caster) and caster:isFacing(target))then

                -- If status effect was inflicted
                if target:addStatusEffect(params.effect, power, tick, duration * resist) then
                    spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
                end
            end
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect

end

-- Inflict an added enfeebling effect (after a physical spell)
function blueDoPhysicalSpellAddedEffect(caster,target,spell,params,damage,power,tick,duration)

    -- Physical spell needs to do damage before added effect can hit
    if damage > 0 then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:addStatusEffect(params.effect, power, tick, duration * resist)
        end
    end

end


-- Function to stagger duration of effects by using the resistance to change the value
-- Intend to render this obsolete, do a find once you've gone through all spells
function getBlueEffectDuration(caster, resist, effect)
    local duration = 0

    if resist == 0.125 then
        resist = 1
    elseif resist == 0.25 then
        resist = 2
    elseif resist == 0.5 then
        resist = 3
    else
        resist = 4
    end

    if effect == xi.effect.BIND then
        duration = math.random(0, 5) + resist * 5
    elseif effect == xi.effect.STUN then
        duration = math.random(2, 3) + resist
    elseif effect == xi.effect.WEIGHT then
        duration = math.random(20, 24) + resist * 9 -- 20-24
    elseif effect == xi.effect.PARALYSIS then
        duration = math.random(50, 60) + resist * 15 -- 50- 60
    elseif effect == xi.effect.SLOW then
        duration = math.random(60, 120) + resist * 15 -- 60- 120 -- Needs confirmation but capped max duration based on White Magic Spell Slow
    elseif effect == xi.effect.SILENCE then
        duration = math.random(60, 180) + resist * 15 -- 60- 180 -- Needs confirmation but capped max duration based on White Magic Spell Silence
    elseif effect == xi.effect.POISON then
        duration = math.random(20, 30) + resist * 9 -- 20-30 -- based on magic spell poison
    else
        duration = math.random(10,30) + resist * 8
    end

    return duration
end

--[[

+-------+
| NOTES |
+-------+

- Spell values (multiplier, TP, D, WSC, TP etc) from:
    - https://www.bg-wiki.com/ffxi/Calculating_Blue_Magic_Damage
    - https://ffxiclopedia.fandom.com/wiki/Calculating_Blue_Magic_Damage
    - BG-wiki spell pages
    - Blue Gartr threads with data, such as
        https://www.bluegartr.com/threads/37619-Blue-Mage-Best-thread-ever?p=5832112&viewfull=1#post5832112
        https://www.bluegartr.com/threads/37619-Blue-Mage-Best-thread-ever?p=5437135&viewfull=1#post5437135
        https://www.bluegartr.com/threads/107650-Random-Question-Thread-XXIV-Occupy-the-RQT?p=4906565&viewfull=1#post4906565
    - When values were absent, spell values were decided based on Blue Gartr threads and Wiki page discussions.

- Assumed INT as the main magic accuracy modifier for physical spells' additional effects (when no data was found).

---------------------------
changes in blu_fixes branch
---------------------------

- Individual spell changes:
    - Updated TP values. A lot of spells had lower TP values for 150/300/Azure, which doesnt't make sense.
    - Updated WSC values, though most were correct.
    - Added spell ecosystem.
    - Streamlined the way spells of the same type are coded.
    - Status/added effect changes:
        - Resistance now influences duration properly.
        - Effects that decay over time now work, such as Wild Oats (VIT down) and Saline Coat (Magic Defense Boost).
        - Some spells had 0 duration.

- Physical Blue Magic spell changes:
    - Simplified some functions.
    - Added Physical Potency merits effect.
    - Added Azure Lore effect on multiplier.
    - Damage is influenced by monster correlation.
    - All physical spells now need to hit before the added effect (AE) can kick in.
    - All physical spells with an AE get a resistance check for the AE.

- Enhancing Blue Magic spell changes:
    - Consolidated Diffusion's effect on duration into one function.

- Enfeebling Blue Magic spell changes:
    - Consolidated enfeebling spells into one function, where possible.
    - Added isGaze/isConal flags.
    - Put the resist threshold in line with other enfeebles (>= 0.5) and halved duration when half-resist.

- Breath Blue Magic spell changes:
    - Corrected breath spells to do breath damage, not magic damage.
    - You have to be in front of the monster to do breath damage.
    - Added an angle damage multiplier that lowers damage when monster is more to your side than in front.
    - Damage is influenced by a monster's elemental resistance, but not by mab/mdb or weather/day bonuses.
    - Damage is influenced by monster correlation.
    - The resist rate is calculated once and affects both damage and added effect hit rate / duration.

- Drain Blue Magic spell changes:
    - Consolidated drain spells into one function.

- General changes:
    - Azure Lore will now allow Physical spells to always skillchain, and Magical spells to always magic burst.
    - Changed all (wrongly named) LUMORIAN and LUMORIAN_KILLER to LUMINIAN and LUMINIAN_KILLER.
    - Added BREATH_DMG_DEALT mod.
    - Updated Mirage Keffiyeh/Mirage Keffiyeh +1/Saurian Helm to have BREATH_DMG_DEALT +10 mods.

- TODOs:
    - "Damage/Accuracy/Critical Hit Rate/Effect Duration varies with TP" is not implemented.
    - Missed physical spells should not be 0 dmg, but there's currently no way to make spells "miss".
    - Sneak Attack / Trick Attack in combination with spells doesn't work, but it should (but not for all spells).
    - Add 75+ spells. I didn't bother personally since we're on a 75 server and I have no knowledge of these spells at all.
    - Add Monster Correlation effect to Magus Keffiyeh (adds another 0.02).
    - Convergence effect isn't coded.
    - Cannot magic burst Breath spells. (bursting Breath spells only affects accuracy, not damage)
        - Burst Affinity doesn't work with Breath spells.
    - Conal calculations on main targets have to be done manually, because they will always hit even if not in cone.
        - Additional targets go through the conal check, but not the main target.
    - Conal calculations on additional targets (not the main target) for Breath spells get a reduced range due to checking a triangle and not a half-circle.
        (see targetfind.cpp > findWithinCone, I didn't want to touch these calculations)



- END RESULT
    - Physical spells
        - acc: acc / DEX
        - dmg: att / STR / stat modifiers / monster correlation
        - Added effect macc: acc / macc / blue magic skill / INT
    - Breath spells
        - dmg: HP / level / elemental resistance / monster correlation (dmg is not influenced by mab/mdb or weather/day bonuses)
        - macc: macc / blue magic skill (no direct stat (such as INT or CHR) increases macc)
    - Drain spells
        - dmg: blue magic skill
        - macc: macc / blue magic skill (no direct stat (such as INT or CHR) increases macc)
    - Enfeebling spells
        - potency: none
        - duration: a .5 resist halves duration, any lower and the spell doesn't hit
        - macc: macc / blue magic skill / INT
    - Correlation = multiplier +- 0.25 (breath multiplier = 1)
    - Azure Lore allows for continuous chaining and bursting
    - Merits
        - Physical Potency: +2 acc per merit
        - Magical Accuracy: TODO
        - Correlation: +0.004 per merit (only for strengths, not weaknesses)
        - Convergence: does not work
        - Enchainment: adds 100 TP per merit
        - Diffusion: adds 5% duration per merit
        - Assimilation: 1 extra point per slot (TO CHECK)


CLEANUP*********************

- TODO OWN:
    - Set spells: DELAY can I do that?
    - Physical AE into one function with params.effect?
    - Enfeebling, also check enhancing for (does not have, like Warm-up, why so complicated?)
    - Gaze check - do myself? isFacing works, but also need isFacing from other side for gaze!
        - Yep gaze is not in DB
- Getstats, put back
- Magic, remove prints
- Remove defmode, although it might come in handy (put in modules for yourself)

]]
