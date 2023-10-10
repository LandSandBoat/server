-----------------------------------
-- AirSkyBoat Lua Module
-- Used to change mobskills luas to era values and use era weaponskills global.
-----------------------------------
require("modules/module_utils")
require("scripts/globals/magic")
require("scripts/globals/mobskills")
-----------------------------------
local m = Module:new("mobskills_onMobSkillCheck")

m:addOverride("xi.globals.mobskills.10000_needles.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.1000_needles.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.2000_needles.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.4000_needles.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.abrasive_tantara.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 and mob:getFamily() == 165 then -- Imps without horn
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.absolute_terror.onMobSkillCheck", function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) or
        mob:hasStatusEffect(xi.effect.SUPER_BUFF) or
        mob:hasStatusEffect(xi.effect.INVINCIBLE) or
        mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) or
        target:isBehind(mob, 96) or
        mob:getAnimationSub() == 1
    then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.absorbing_kiss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.abyssal_drain.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.abyssal_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.abyss_blast.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.acid_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.acid_mist.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.acid_spray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.acrid_stream.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.actinic_burst.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.activate.onMobSkillCheck", function(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.aegis_schism.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aeolian_void.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aerial_armor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aerial_blast.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aerial_collision.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aerial_wheel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aero_ii.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aero_iv.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aero_meeble_warble.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.airy_shield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.amatsu_hanaikusa.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getObjType() == xi.objType.TRUST or
        mob:getAnimationSub() == 0
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.amatsu_kazakiri.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getObjType() == xi.objType.TRUST or
        mob:getAnimationSub() == 0
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.amatsu_torimai.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getObjType() == xi.objType.TRUST or
        mob:getAnimationSub() == 0
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.amatsu_tsukikage.onMobSkillCheck", function(target, mob, skill)
    if mob:getObjType() == xi.objType.TRUST then
        return 0
    else
        return 1 --if BCNM version dont use this
    end
end)

m:addOverride("xi.globals.mobskills.amatsu_tsukioboro.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getObjType() == xi.objType.TRUST or
        mob:getAnimationSub() == 0
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.amatsu_yukiarashi.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getObjType() == xi.objType.TRUST or
        mob:getAnimationSub() == 0
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.amber_scutum.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.amon_drive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.amorphic_spikes.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.amplification.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.animating_wail.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.antigravity.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.antigravity_1.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.antigravity_2.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.antigravity_3.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.antimatter.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.antiphase.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.apocalyptic_ray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aqua_ball.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aqua_ball_knockback.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aqua_blast.onMobSkillCheck", function(target, mob, skill)
    -- Do not use this weapon skill on targets behind.
    -- Sub-Zero Smash should trigger in this case.
    if target:isBehind(mob) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.aqua_breath.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.arcane_stomp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.arching_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.arctic_impact.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.arcuballista.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ark_guardian_tarutaru.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.armor_break.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.armor_buster.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.armor_piercer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.arm_block.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.artificial_gravity.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.artificial_gravity_1.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.artificial_gravity_2.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.artificial_gravity_3.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ascetics_fury.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.asthenic_fog.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.astral_flow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

local function petInactive(pet)
    return
        pet:hasStatusEffect(xi.effect.LULLABY) or
        pet:hasStatusEffect(xi.effect.STUN) or
        pet:hasStatusEffect(xi.effect.PETRIFICATION) or
        pet:hasStatusEffect(xi.effect.SLEEP_II) or
        pet:hasStatusEffect(xi.effect.SLEEP_I) or
        pet:hasStatusEffect(xi.effect.TERROR)
end

m:addOverride("xi.globals.mobskills.astral_flow_pet.onMobSkillCheck", function(target, mob, skill)
    -- must have pet
    if not mob:hasPet() then
        return 1
    end

    local pet = mob:getPet()

    if pet:getID() == mob:getID() then
        return 1
    end

    -- pet must be an avatar, and active
    if pet:getEcosystem() ~= 5 or petInactive(pet) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.asuran_claws.onMobSkillCheck", function(target, mob, skill)
    -- animsub 1= standing, animsub 0 = all fours
    if mob:getAnimationSub() == 0 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.asuran_fists.onMobSkillCheck", function(target, mob, skill)
    -- maat can only use this at 70
    if mob:getMainLvl() < 70 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.august_melee_axe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.august_melee_bow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.august_melee_h2h.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.august_melee_sword.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.aura_of_persistence.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.auroral_drape.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.auroral_uppercut.onMobSkillCheck", function(target, mob, skill)
    if
        target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.auroral_wind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.autumn_breeze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.avalanche_axe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.awful_eye.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.axe_kick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.axe_throw.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.BST then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.axial_bloom.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.azure_lore.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.backhand_blow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.back_heel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.back_swish.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bad_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bai_wing.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.baleful_gaze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bane.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.barbed_crescent.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.barofield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.barracuda_dive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.barrage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.barrier_tusk.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.bastion_of_twilight.onMobSkillCheck", function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.MAGIC_SHIELD) or
        mob:hasStatusEffect(xi.effect.PHYSICAL_SHIELD)
    then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.batterhorn.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.battery_charge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.battle_dance.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.beak_lunge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bear_killer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.beatdown.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.benediction.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.benthic_typhoon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.berserk-ruf.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.berserk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.big_horn.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.big_scissors.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bilgestorm.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.binary_absorption.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.binary_tap.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.binding_microtube.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.binding_wave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bionic_boost.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.biotic_boomerang.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.black_cloud.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.black_halo.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_chi.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_ei.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_jin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_ku.onMobSkillCheck", function(target, mob, skill)
    --
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_metsu.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_retsu.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_rin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_teki.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blade_to.onMobSkillCheck", function(target, mob, skill)
    --
    return 0
end)

m:addOverride("xi.globals.mobskills.blank_gaze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blank_gaze_dispel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blastbomb.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blaster.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blast_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blazing_bound.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blindeye.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blind_vortex.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blitzstrahl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blizzard_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blizzard_ii.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blizzard_iv.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blizzard_meeble_warble.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blockhead.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bloodrake.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bloody_caress.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bloody_claw.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 4 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.blood_drain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blood_pact.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif
        GetMobByID(mob:getID() + 2):isAlive() and
        mob:getPool() == 1296
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.blood_saber.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blood_weapon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.blow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bludgeon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.body_slam.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.boiling_blood.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.boiling_point.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bombilation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bomb_toss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bomb_toss_suicide.onMobSkillCheck", function(target, mob, skill)
    --[[
    BombToss Suicide should happen approx 15% of the time a goblin throws a bomb
    goblin_rush and bomb_toss are assumed to be close to 50/50 activation rate
    This nets a roughly 7.5% activation rate.

    To achieve a 7.5% activation we have to consider how a mob skill is chosen.
    The entire skill list is shuffled and then checked starting from the first element.
    In this scenario we have 3 skills to consider resulting in a ~33% chance for each
    .: we should set bomb_toss_suicide's threshold to be 23%.  33% * 23% = ~7.5%
    This gives us a roughly 46% goblin_rush rate and a combined ~54% bomb_toss rate
    Not exactly 50% goblin_rush 35% bomb_toss and 15% bomb_toss_suicide

    A more involved fix is one of the following:
    - Changing the mob skill list to support weighting (we currently do this mob by mob in OnMobWeaponSkillPrepare)
    - Changing OnMobWeaponSkillPrepare to support a family level check (perhaps loading a family mixin file and looking for OnMobWeaponSkillPrepare)
    - Adding a mixin (and a lua file) for every goblin in vanadiel (there are a lot of goblins. lets not do that)
    Its worth nothing that I am only aware of two families which would make use of this.  Goblins and Moblins
    ]]

    local suicideCheck = math.random(0, 100)
    if
        not mob:isNM() and
        not mob:isInDynamis() and -- Campaign too eventually
        suicideCheck <= 23
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.bonebreaking_barrage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bone_crunch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bone_crusher.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.brainjack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.brainshaker.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.brain_crush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.brain_drain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.brain_spike.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.bubble_armor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bubble_curtain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.bubble_shower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.burning_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.burst.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cacodemonia.onMobSkillCheck", function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.CURSE_I) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.calamity.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.calcifying_claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.call_beast.onMobSkillCheck", function(target, mob, skill)
    -- Don't summon if a pet is already out
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    -- If it's not already out, make sure we're passed the minimum time
    if os.time() < mob:getLocalVar("CallBeastTime") then
        return 1
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end)

m:addOverride("xi.globals.mobskills.call_of_the_grave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.call_wyvern.onMobSkillCheck", function(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.camisado.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cannonball.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 5 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.carnal_nightmare.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.carousel.onMobSkillCheck", function(target, mob, skill)
    if
        mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or
        mob:isMobType(xi.mobskills.mobType.BATTLEFIELD)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.catapult.onMobSkillCheck", function(target, mob, skill)
    -- Ranged attack only used when target is out of range
    if mob:checkDistance(target) > 2 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.catastrophe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.catharsis.onMobSkillCheck", function(target, mob, skill)
    -- TODO: Make separate mob skill list for CoP Hecteyes
    if
        target:getCurrentRegion() == xi.region.TAVNAZIANARCH or
        mob:getPool() == 3693 -- Sobbing Eyes
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.chainspell.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chains_of_apathy.onMobSkillCheck", function(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if v.entity:isPC() then
            local race = v.entity:getRace()
            if
                (race == xi.race.HUME_M or race == xi.race.HUME_F) and
                not v.entity:hasKeyItem(xi.ki.LIGHT_OF_VAHZL)
            then
                mob:showText(mob, ID.text.PROMATHIA_TEXT)
                return 0
            end
        end
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.chains_of_arrogance.onMobSkillCheck", function(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if v.entity:isPC() then
            local race = v.entity:getRace()
            if
                (race == xi.race.ELVAAN_M or race == xi.race.ELVAAN_F) and
                not v.entity:hasKeyItem(xi.ki.LIGHT_OF_MEA)
            then
                mob:showText(mob, ID.text.PROMATHIA_TEXT + 1)
                return 0
            end
        end
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.chains_of_cowardice.onMobSkillCheck", function(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if v.entity:isPC() then
            local race = v.entity:getRace()
            if
                (race == xi.race.TARU_M or race == xi.race.TARU_F) and
                not v.entity:hasKeyItem(xi.ki.LIGHT_OF_HOLLA)
            then
                mob:showText(mob, ID.text.PROMATHIA_TEXT + 2)
                return 0
            end
        end
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.chains_of_envy.onMobSkillCheck", function(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if v.entity:isPC() then
            local race = v.entity:getRace()
            if
                race == xi.race.MITHRA and
                not v.entity:hasKeyItem(xi.ki.LIGHT_OF_DEM)
            then
                mob:showText(mob, ID.text.PROMATHIA_TEXT + 3)
                return 0
            end
        end
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.chains_of_rage.onMobSkillCheck", function(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if v.entity:isPC() then
            local race = v.entity:getRace()
            if
                race == xi.race.GALKA and
                not v.entity:hasKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
            then
                mob:showText(mob, ID.text.PROMATHIA_TEXT + 4)
                return 0
            end
        end
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.chaos_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chaos_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chaotic_eye.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chaotic_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.charged_whisker.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.charm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.charm_copycat.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chemical_bomb.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chimera_ripper.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.choke_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chomp_rush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.chthonian_ray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cimicine_discharge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.circle_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.circle_of_flames.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 6 then -- 1 bomb
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.citadel_buster.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.clarsach_call.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.claw_cyclone.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.claw_storm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cocoon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cold_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cold_stare.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cold_wave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.colossal_blow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.colossal_slam.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.combo.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.concussive_oscillation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.condemnation.onMobSkillCheck", function(target, mob, skill)
    local zone = mob:getZoneID()
    if mob:isInDynamis() or zone == 5 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.contagion_transfer.onMobSkillCheck", function(target, mob, skill)
return 0
end)

m:addOverride("xi.globals.mobskills.contamination.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.core_meltdown.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    elseif mob:getAnimationSub() ~= 0 then -- form check
        return 1
    elseif math.random(1, 100) >= 5 then -- here's the 95% chance to not blow up
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.coronach.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.corrosive_ooze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cosmic_elucidation.onMobSkillCheck", function(target, mob, skill)
    return 1 -- only scripted use
end)

m:addOverride("xi.globals.mobskills.crescent_fang.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crescent_moon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crimson_howl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crispy_candle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.critical_bite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cronos_sling_eta.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 0 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.cronos_sling_lambda.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 2 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.cronos_sling_theta.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.crossthrash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crosswind.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1746 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.cross_attack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cross_reaper.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cross_reaver.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cryo_jet.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crystaline_cocoon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crystal_rain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crystal_shield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_fire.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_stone.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_water.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.crystal_weapon_wind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.curse.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cursed_sphere.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cyclone.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cyclone_wing.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 1
    elseif target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.cyclonic_torrent.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cyclonic_turmoil.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cyclotail.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.cytokinesis.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.damnation_dive.onMobSkillCheck", function(target, mob, skill)
    if
        (mob:getFamily() == 122 or
        mob:getFamily() == 123 or
        mob:getFamily() == 124) and
        mob:getAnimationSub() ~= 3
    then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.dancing_chains.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dancing_edge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.danse_macabre.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dark_harvest.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dark_mist.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 5 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.dark_nova.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.dark_orb.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 5 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.dark_sphere.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dark_spore.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dark_wave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.daze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.deadeye.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.deadly_drive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.deadly_hold.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.deafening_tantara.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 and mob:getFamily() == 165 then -- Imps without horn
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.deal_out.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.death_ray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.death_scissors.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.death_trap.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.debonair_rush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.decayed_filament.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 2 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.decussate.onMobSkillCheck", function(target, mob, skill)
    if mob:getPool() == 1846 and mob:getHP() < mob:getMaxHP() / 100 * 35 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.deep_kiss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.delta_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.demonic_flower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.demonic_howl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.demoralizing_roar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.depuration.onMobSkillCheck", function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel ~= xi.effect.NONE then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.diamondhide.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.STONESKIN) then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.diamond_dust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_curse.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_damage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_disease.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_dispel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_heal.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_poison.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_reset.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_sleep.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_slow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_stun.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dice_tp_loss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.diffusion_ray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.digest.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 290 then -- Claret
        if mob:checkDistance(target) < 3 then -- Don't use it if he is on his target.
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.dimensional_death.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dirty_claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.discharge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.discharger.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.discoid.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dispelling_wind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.disseverment.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dissipation.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.dissolve.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.divesting_stampede.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.divine_spear.onMobSkillCheck", function(target, mob, skill)
    -- Only used if player with hate is in front.
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.doctors_orders.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dominion_slash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.doom.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.double_claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.double_down.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.double_kick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.double_punch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.double_ray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.double_slap.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.double_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dragonfall.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dragon_breath.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.dragon_kick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.drainkiss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.drain_whip.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dreadstorm.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1805 then
            return 0
        else
            return 1
        end
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.dread_dive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dread_shriek.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dream_flower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.drill_branch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.drill_claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.drop_hammer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dual_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dukkeripen_heal.onMobSkillCheck", function(target, mob, skill)
    if mob:getMainJob() == xi.job.COR then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.dukkeripen_para.onMobSkillCheck", function(target, mob, skill)
    if mob:getMainJob() == xi.job.COR then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.dukkeripen_shadow.onMobSkillCheck", function(target, mob, skill)
    if mob:getMainJob() == xi.job.COR then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.dulling_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dustvoid.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dust_cloud.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dynamic_assault.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.dynamic_implosion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.eagle_eye_shot.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.eald2_warp_in.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.eald2_warp_out.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.earthbreaker.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.earthen_fury.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.earthen_ward.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.earth_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.earth_breath.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.earth_crusher.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.earth_maneuver.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif
        GetMobByID(mob:getID() + 1):isAlive() and
        mob:getPool() == 1296
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.earth_pounder.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.earth_shock.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.echo_drops.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.eclipse_bite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ectosmash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.electrocharge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.electromagnetic_field.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.emetic_discharge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empirical_research.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empty_beleaguer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empty_crush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empty_cutter.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empty_cutter_thinker.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empty_salvation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empty_seed.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.empty_thrash.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.energy_screen.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        mob:getStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.energy_steal.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.enervation.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1680 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.entangle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.entice.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.envoutement.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.epoxy_spread.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.equalizer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.erratic_flutter.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.eternal_damnation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.evasion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.everyones_grudge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.everyones_rancor.onMobSkillCheck", function(target, mob, skill)
    if
        mob:isNM() and
        mob:getHP() / mob:getMaxHP() <= 0.25 and
        mob:getLocalVar("everyonesRancorUsed") == 0
    then
        mob:setLocalVar("everyonesRancorUsed", 1)
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.evisceration.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.extremely_bad_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.exuviation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.eyes_on_me.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.eye_scratch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.familiar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fanatic_dance.onMobSkillCheck", function(target, mob, skill)
    if mob:isInDynamis() and mob:getLocalVar("MobIndex") ~= 0 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.fang_rush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fantod.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fast_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.faze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fear_touch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.feather_barrier.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.feather_maelstrom.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.feather_storm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.feather_tickle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.feeble_bleat.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fell_cleave.onMobSkillCheck", function(target, mob, skill)
    --
    return 0
end)

m:addOverride("xi.globals.mobskills.fevered_pitch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fiery_breath.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        return 1
    elseif target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.filamented_hold.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.final_exam.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.final_heaven.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.final_retribution.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.final_sting.onMobSkillCheck", function(target, mob, skill)
    local param = skill:getParam()
    if param == 0 then
        param = 33
    end

    if mob:getHPP() <= param then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.fireball.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.firebomb.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.firespit.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1639 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.fire_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fire_break.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fire_ii.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fire_iv.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fire_maneuver.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID() + 1):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.fire_meeble_warble.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fission.onMobSkillCheck", function(target, mob, skill)
    local id = mob:getID()

    for i = id + 1, id + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if not baby:isSpawned() then
            return 0
        end
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.flailing_trunk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flame_armor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flame_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flame_blast.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.flame_blast_alt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flame_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flame_thrower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flaming_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flaming_crush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flat_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.floodlight.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fluid_spread.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fluid_toss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fluid_toss_claret.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flurry_of_rage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.flying_hip_press.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.foot_kick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.forceful_blow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.formation_attack.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 6  then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.fortifying_wail.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fossilizing_breath.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1805 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.foul_breath.onMobSkillCheck", function(target, mob, skill)
    -- not used in Uleguerand_Range
    if mob:getZoneID() == 5 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.fountain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.foxfire.onMobSkillCheck", function(target, mob, skill)
    local job = mob:getMainJob()

    -- TODO: Table this
    if
        job == xi.job.RDM or
        job == xi.job.THF or
        job == xi.job.PLD or
        job == xi.job.BST or
        job == xi.job.RNG or
        job == xi.job.BRD or
        job == xi.job.NIN or
        job == xi.job.COR
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.freezebite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.freeze_rush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frenetic_rip.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 and mob:getFamily() == 165 then -- Imps - with horn
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.frenzied_rage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frenzy_pollen.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frightful_roar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frigid_shuffle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frogkick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frog_cheer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frostbite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frost_armor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frost_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.frost_breath.onMobSkillCheck", function(target, mob, skill)
    -- only used in Uleguerand_Range
    if mob:getZoneID() == 5 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.frypan.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.full-force_blow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.full_swing.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.fulmination.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1805 then
            return 0
        else
            return 1
        end
    end

    local family = mob:getFamily()
    local mobhp = mob:getHPP()
    local result = 1

    if family == 168 and mobhp <= 35 then -- Khimaira < 35%
        result = 0
    elseif family == 315 and mobhp <= 50 then -- Tyger < 50%
        result = 0
    end

    return result
end)

m:addOverride("xi.globals.mobskills.fuscous_ooze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gaea_stream_eta.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 0 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.gaea_stream_lambda.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 2 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.gaea_stream_theta.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.gala_macabre.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gale_axe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gastric_bomb.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gas_shell.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gates_of_hades.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1793 then
            return 0
        else
            return 1
        end
    end

    local result = 1
    local mobhp = mob:getHPP()

    if mobhp <= 25 then
        result = 0
    end

    return result
end)

m:addOverride("xi.globals.mobskills.gate_of_tartarus.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.geirskogul.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.geist_wall.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.geocrush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.geotic_breath.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.gerjis_grip.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.geush_auto.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gigaflare.onMobSkillCheck", function(target, mob, skill)
    local mobhp = mob:getHPP()

    if mob:getID() == 16896156 and mobhp <= 10 then -- set up Gigaflare for being called by the script again.
        mob:setLocalVar("GigaFlare", 0)
        mob:setMobAbilityEnabled(false) -- disable mobskills/spells until Gigaflare is used successfully (don't want to delay it/queue Megaflare)
        mob:setMagicCastingEnabled(false)
    elseif mob:getID() == 16896157 and mob:getLocalVar("TeraFlare") ~= 0 then -- make sure Teraflare has happened first - don't want a random Gigaflare to block it.
        mob:setLocalVar("GigaFlareQueue", 1) -- set up Gigaflare for being called by the script again.
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.giga_scream.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.giga_slash.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.glacial_breath.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.glacier_splitter.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gliding_spike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.glittering_ruby.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gloeosuccus.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.goblin_rush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gospel_of_the_lost.onMobSkillCheck", function(target, mob, skill)
    -- Lets not heal if we haven't taken any damage..
    if mob:getHPP() == 100 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.grand_fall.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.grand_slam.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.granite_skin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.grapple.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.grave_reel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gravitic_horn.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gravity_field.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gravity_wheel.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 2 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.great_bleat.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.great_sandstorm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.great_wheel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.great_whirlwind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gregale_wing.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    elseif target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.gregale_wing_air.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.grim_halo.onMobSkillCheck", function(target, mob, skill)
    local job = mob:getMainJob()
    if
        job == xi.job.WAR or
        job == xi.job.BLM or
        job == xi.job.DRK or
        job == xi.job.SAM or
        job == xi.job.DRG or
        job == xi.job.SMN
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.ground_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.guided_missile.onMobSkillCheck", function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.guided_missile_ii.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.guillotine.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.gusting_gouge.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getAnimationSub() == 0 and
        (
            mob:getMainJob() == xi.job.COR or
            mob:getMainJob() == xi.job.BRD or
            mob:getMainJob() == xi.job.RDM
        )
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.gust_slash.onMobSkillCheck", function(target, mob, skill)
    --
    return 0
end)

m:addOverride("xi.globals.mobskills.hammer-go-round.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hammer_beak.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hane_fubuki.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.happobarai.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.harden_shell.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hard_membrane.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hard_slash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.havoc_spiral.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.haymaker.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.head_butt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.head_butt_turtle.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.head_snatch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.healing_breeze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.healing_ruby.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.healing_ruby_ii.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heat_barrier.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heat_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heavenly_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heavy_armature.onMobSkillCheck", function(target, mob, skill)
    if mob:getPool() == 243 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.heavy_bellow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heavy_blow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heavy_stomp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heavy_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heavy_swing.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.heavy_whisk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hecatomb_wave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hellclap.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1839 then
            return 0
        else
            return 1
        end
    end

    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.helldive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hellfire_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hellsnap.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1839 then
            return 0
        else
            return 1
        end
    end

    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.hell_slash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hexagon_belt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hexa_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hexidiscs.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 0 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.hex_eye.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hex_palm.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 or mob:getAnimationSub() == 3 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.hi-freq_field.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hiden_sokyaku.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hiemal_storm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.high-tension_discharger.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hoof_volley.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.horrible_roar.onMobSkillCheck", function(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.horrid_roar_1.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.horrid_roar_2.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.horrid_roar_3.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.horror_cloud.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hot_shot.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.howl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.howling.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.howling_fist.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.howling_moon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hundred_fists.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hungry_crunch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hurricane_wing.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.hurricane_wing_flying.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.hydro_ball.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hydro_canon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hydro_shot.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hyper-potion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hyper_pulse.onMobSkillCheck", function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.hypnosis.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hypnotic_sway.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hypothermal_combustion.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.hysteric_assault.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.hysteric_barrage.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.ice_break.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ice_maneuver.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID() + 1):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.ice_roar.onMobSkillCheck", function(target, mob, skill)
    if mob:getZoneID() == 135 or mob:getZoneID() == 111 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.ichor_stream.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ill_wind.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 and mob:getModelId() == 1746 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.immortal_anathema.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.impact_roar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.impact_stream.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.impale.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.impalement.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.implosion.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.impulse_drive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.impulsion.onMobSkillCheck", function(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.incensed_pummel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.incessant_fists.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.incinerate.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.infernal_deliverance.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.infernal_pestilence.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.inferno.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.inferno_blast.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.inferno_blast_alt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.infrasonics.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ink_cloud.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ink_jet.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ink_jet_alt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.insipid_nip.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.inspirit.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.intimidate.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.invincible.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ion_efflux.onMobSkillCheck", function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.ion_shower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.iridal_pierce.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.iron_tempest.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.jamming_wave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.javelin_throw.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.DRG then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.jettatura.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.jet_stream.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.judgment.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.judgment_bolt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.jump.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.jumping_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.kartstrahl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.keen_edge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.kibosh.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.kick_back.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.kick_out.onMobSkillCheck", function(target, mob, skill)
    if not target:isBehind(mob, 48) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.king_cobra_clamp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.knife_edge_circle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.knights_of_round.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.knockout.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lamb_chop.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lamentation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.laser_shower.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.lateral_slash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lateral_slash_2hr.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lava_spit.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1793 then
            return 0
        else
            return 1
        end
    end

    if target:isBehind(mob, 48) then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.lead_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.leafstorm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.leaf_dagger.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.leaping_cleave.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.leg_sweep.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lesson_in_pain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lethe_arrows.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.level_5_petrify.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lightning_armor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lightning_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lightning_roar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.light_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.light_of_penance.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lodesong.onMobSkillCheck", function(target, mob, skill)
    if
        mob:isInDynamis() and
        not mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return 0
    end

    -- can only used if not silenced
    if
        mob:getMainJob() == xi.job.BRD and
        not mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.lowing.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.luminous_drape.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.luminous_lance.onMobSkillCheck", function(target, mob, skill)
    local lanceTime = mob:getLocalVar("lanceTime")
    local lanceOut = mob:getLocalVar("lanceOut")

    if
        not (target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) and target:hasStatusEffect(xi.effect.MAGIC_SHIELD)) and
        lanceTime + 60 < mob:getBattleTime() and
        target:getCurrentAction() ~= xi.act.MOBABILITY_USING and
        lanceOut == 1
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.lunar_cry.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lunar_revolution.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lunar_roar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lunatic_voice.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.lux_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.maats_bash.onMobSkillCheck", function(target, mob, skill)
    if mob:getPool() == 5408 then -- PLD
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.maelstrom.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.magic_barrier.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.magic_fruit.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.magic_hammer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.magic_mortar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.magma_fan.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.magma_hoplon.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.STONESKIN) then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.magnetite_cloud.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.malediction.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.malevolent_blessing.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.manafont.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mana_screen.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        mob:getStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.mana_storm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mandible_bite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mandibular_bite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mangle.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 or mob:getAnimationSub() == 2 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.mantle_pierce.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_2hr.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_attk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_def.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_hp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_hp_mp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_ja_reset.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_mp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_special.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_tp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marionette_dice_tp_player.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.marrow_drain.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.material_fend.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.max_potion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.meditate.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.medusa_javelin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.megaflare.onMobSkillCheck", function(target, mob, skill)
    local mobhp = mob:getHPP()

    if mobhp <= 10 and mob:getLocalVar("GigaFlare") ~= 0 then -- make sure Gigaflare has happened first - don't want a random Megaflare to block it.
        mob:setLocalVar("MegaFlareQueue", 1) -- set up Megaflare for being called by the script again.
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.megalith_throw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mega_holy.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.meikyo_shisui.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.meltdown.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.memento_mori.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.memory_of_dark.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mercurial_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mercy_stroke.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.metallic_body.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.STONESKIN) then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.metatron_torment.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.meteor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.meteorite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.meteor_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.methane_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.miasma.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.microquake.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 2 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.mighty_snort.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mighty_strikes.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mijin_gakure.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mind_blast.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mind_break.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mind_drain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mind_purge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mind_wall.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 3 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.mine_blast.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mirage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mistral_axe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_antidote.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_dark_potion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_dragon_shield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_dry_ether_concoction.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_elemental_power.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_guard_drink.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_life_water.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_max_potion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_panacea-1.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mix_samsons_strength.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.moblin_1343.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.moblin_1344.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.moblin_1345.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.molluscous_mutation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.molting_burst.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.moonlight.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.moonlit_charge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mortal_ray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mortal_revolution.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mountain_buster.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mp_absorption.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mp_drainkiss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mucus_spread.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.murk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.mysterious_light.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.namas_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.necrobane.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1839 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.necropurge.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1839 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.needleshot.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.negative_whirl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.nepenthean_hum.onMobSkillCheck", function(target, mob, skill)
    if VanadielHour() >= 6 and VanadielHour() <= 18 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.nerve_gas.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then -- PW
        local mobSkin = mob:getModelId()
        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    elseif mob:getFamily() == 313 then -- Tinnin can use at will
        return 0
    else
        if mob:getAnimationSub() == 0 then
            return 0
        else
            return 1
        end
    end
end)

m:addOverride("xi.globals.mobskills.netherspikes.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.nether_blast.onMobSkillCheck", function(target, mob, skill)
    -- Ranged attack only used when target is out of range
    if mob:checkDistance(target) > 2 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.nightmare.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.nightmare_scythe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.nihility_song.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.nimble_snap.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.noctoshield.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.PHALANX) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.nocturnal_combustion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.noisome_powder.onMobSkillCheck", function(target, mob, skill)
    if VanadielHour() >= 6 and VanadielHour() <= 18 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.nuclear_waste.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.nullifying_dropkick.onMobSkillCheck", function(target, mob, skill)
    if
        target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.numbing_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.numbing_glare.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.numbing_noise.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.numbshroom.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.obfuscate.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.oblivion_smash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.occultation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ochre_blast.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.ochre_blast_alt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.oisoya.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getAnimationSub() == 5 or
        mob:getAnimationSub() == 6
    then -- if tenzen is in bow mode
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.omega_javelin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.one-ilm_punch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.one_inch_punch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.onrush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.onslaught.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.optic_induration.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 2 or mob:getAnimationSub() == 3 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.optic_induration_charge.onMobSkillCheck", function(target, mob, skill)
    -- Rarely used Optic Induration. Only charge if not an NM and in normal mode (no bars or rings)
    if mob:getAnimationSub() >= 2 or utils.chance(75) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.ore_toss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.osmosis.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.painful_whip.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.palsynyxis.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.palsy_pollen.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pandemic_nip.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.panzerfaust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.panzerschreck.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.paralysis_shower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.paralyzing_microtube.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.parry.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.particle_shield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.peacebreaker.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pecking_flurry.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.penta_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.penumbral_impact.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.percussive_foin.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 2 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.perdition.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.perfect_defense.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.perfect_dodge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pestilent_penance.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.petal_pirouette.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.petribreath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.petrifaction.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.petrifactive_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.petro_eyes.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.petro_gaze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pet_flame_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pet_frost_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pet_gust_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pet_hydro_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pet_lightning_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pet_sand_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.phantasmal_dance.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.phase_shift_1.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.phase_shift_2.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.phase_shift_3.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.photosynthesis.onMobSkillCheck", function(target, mob, skill)
    -- only used during daytime
    local currentTime = VanadielHour()
    if currentTime >= 6 and currentTime <= 18 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.piercing_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pile_pitch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pinecone_bomb.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pit_ambush.onMobSkillCheck", function(target, mob, skill)
    if
        (skill:getID() == 1844 or
        mob:getPool() == 1318) and
        mob:getLocalVar("AMBUSH") == 1
    then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.plague_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.plague_swipe.onMobSkillCheck", function(target, mob, skill)
    -- TODO: Replace this when there's a better method than isFacingTheSameDirection() aka isBehind
    if not target:isBehind(mob) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.plasma_charge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pleiades_ray.onMobSkillCheck", function(target, mob, skill)
    local mobhp = mob:getHPP()

    if mobhp <= 20 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pl_body_slam.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 421 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pl_chaos_blade.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 421 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pl_heavy_stomp.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 421 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pl_hellstorm.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 281 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pl_petro_eyes.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 421 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pl_vulcanian_impact.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 281 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pod_ejection.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.poison_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.poison_nails.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.poison_pick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.poison_sting.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.polar_blast.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    end

    if mob:getAnimationSub() <= 1 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.polar_bulwark.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    end

    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pollen.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pounce.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.power_attack.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId() --Mobskill based on modelid, this is for all h2h models
    if
        mobSkin == 271 or
        mobSkin == 642 or
        mobSkin == 643 or
        mobSkin == 709 or
        mobSkin == 711
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.power_attack_beetle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.power_attack_weapon.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId() -- Mobskill based on modelid, these are the gigas with weapons
    if
        mobSkin == 274 or
        mobSkin == 275 or
        mobSkin == 640 or
        mobSkin == 703 or
        mobSkin == 707 or
        mobSkin == 708 or
        mobSkin == 710 or
        mobSkin == 720
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.power_slash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.predator_claws.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.primal_drill.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.prishe_item_1.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.prishe_item_2.onMobSkillCheck", function(target, mob, skill)
    if
        target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    elseif
        mob:hasStatusEffect(xi.effect.PLAGUE) or
        mob:hasStatusEffect(xi.effect.CURSE_I) or
        mob:hasStatusEffect(xi.effect.MUTE)
    then
        return 0
    elseif math.random() < 0.25 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.proboscis_shower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.prodigious_spike.onMobSkillCheck", function(target, mob, skill)
    -- Can always use, only if target is behind and not exclusive like spike flail
    if not target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.promyvion_barrier.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.promyvion_brume.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.provoke.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.psychomancy.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 3 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.punch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.purulent_ooze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.pw_calcifying_deluge.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 1865 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pw_groundburst.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 1863 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pw_pinning_shot.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 1865 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pw_shadow_thrust.onMobSkillCheck", function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 1865 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pyric_blast.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    end

    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.pyric_bulwark.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    end

    -- TODO: Used only when second/left head is alive (animationsub 0 or 1)
    if mob:getAnimationSub() <= 1 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.quadrastrike.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or mob:isInDynamis() then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.quadratic_continuum.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.quake_stomp.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1680 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.queasyshroom.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.questionmarks_needles.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.radiant_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.radiant_sacrament.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.raging_axe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.raging_fists.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.raging_rush.onMobSkillCheck", function(target, mob, skill)
    --
    return 0
end)

m:addOverride("xi.globals.mobskills.raiden_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rail_cannon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rail_cannon_1.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rail_cannon_2.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rail_cannon_3.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rampage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rampant_gnaw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ram_charge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.randgrith.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.random_kiss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ranged_attack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rapid_molt.onMobSkillCheck", function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel ~= xi.effect.NONE then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.razor_fang.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.reactive_armor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.reactive_shield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.reactor_cool.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() > 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.reactor_overheat.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 3 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.reactor_overload.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 3 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.rear_lasers.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.recoil_dive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.red_lotus_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.refueling.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.regain_hp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.regain_mp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.regeneration.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.regurgitation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rejuvenation.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.rending_deluge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.reprobation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.restoral.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.revelation.onMobSkillCheck", function(target, mob, skill)
    if target:getFamily() == 478 and mob:getLocalVar("lanceOut") == 0 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.rhino_attack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rhino_guard.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.riceball.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.riddle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rime_spray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rinpyotosha.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ripper_fang.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.roar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rock_crusher.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rock_smash.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1680 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.rock_throw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rot_gas.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.royal_bash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.royal_savior.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ruinous_omen.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rumble.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rushing_drub.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.rushing_slash.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.BST then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.rushing_stab.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.DRG then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.sable_breath.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.saline_coat.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sandspin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sandspray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sandstorm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sand_blast.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sand_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sand_pit.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sand_shield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sand_trap.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sand_veil.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.saucepan.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.savage_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scintillant_lance.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scission_thrust.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.scissor_guard.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scorching_lash.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1793 then
            return 0
        else
            return 1
        end
    end

    if not target:isBehind(mob, 48) then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.scourge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scouring_bubbles.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scratch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scream.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.screwdriver.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scutum.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.scythe_tail.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.seal_of_quiescence.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.searing_light.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.secretion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.seedspray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.seismostomp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.self-destruct.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or mob:getHPP() > 75 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.self-destruct_1.onMobSkillCheck", function(target, mob, skill)
    if mob:getHPP() > 21 or mob:getAnimationSub() ~= 6  then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.self-destruct_2.onMobSkillCheck", function(target, mob, skill)
    if mob:getHPP() > 32 or mob:getAnimationSub() ~= 5 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.self-destruct_2death.onMobSkillCheck", function(target, mob, skill)
    if (mob:getHPP() > 32 or mob:getAnimationSub() ~= 5) and math.random() < .2 then -- 20% chance for all bombs to explode
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.self-destruct_3.onMobSkillCheck", function(target, mob, skill)
    if mob:getHPP() > 66 or mob:getAnimationSub() ~= 4 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.self-destruct_321.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.self-destruct_3death.onMobSkillCheck", function(target, mob, skill)
    if (mob:getHPP() > 66 or mob:getAnimationSub() ~= 4) and math.random() < .2 then -- 20% chance for all bombs to explode
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.sentinel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.seraph_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.seraph_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.serpentine_tail.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    elseif mob:getFamily() == 313 then -- Tinnin
        if mob:getAnimationSub() < 2 and target:isBehind(mob, 48) then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.severing_fang.onMobSkillCheck", function(target, mob, skill)
    -- Do not use this weapon skill on targets behind. Sub-Zero Smash
    -- should trigger in this case.
    if target:isBehind(mob) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.shackled_fists.onMobSkillCheck", function(target, mob, skill)
    if mob:getMainJob() == xi.job.MNK then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.shadowstitch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shadow_claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shadow_of_death.onMobSkillCheck", function(target, mob, skill)
    --
    return 0
end)

m:addOverride("xi.globals.mobskills.shadow_spread.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shakeshroom.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 2 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.shantotto_ii_melee.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shark_bite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sharp_sting.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sharp_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sheep_charge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sheep_charge_melee.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sheep_song.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shell_bash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shell_crusher.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shell_guard.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shibaraku.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shield_bash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shield_break.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shield_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shiko_no_mitate.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shining_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shining_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shockwave.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.shock_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shock_wave.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.shoulder_attack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shoulder_slam.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shoulder_tackle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.shuffle.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.sic.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID() + 3):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.sickle_moon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sickle_slash.onMobSkillCheck", function(target, mob, skill)
    if
        (mob:getFamily() == 122 or mob:getFamily() == 123 or mob:getFamily() == 124) and
        mob:getAnimationSub() ~= 2
    then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.sideswipe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sidewinder.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sigh.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.silence_gas.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.silence_seal.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.silencing_microtube.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sinuate_rush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.siphon_discharge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.skewer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.skullbreaker.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.slam_dunk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.slapstick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.slaverous_gale.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sledgehammer.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sleet_blast.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.sleet_blast_alt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.slice.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sling_bomb.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 6  then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.slipstream.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.slumber_powder.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.smash_axe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.smite_of_fury.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.smite_of_rage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.smite_of_rage_2hr.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.smokebomb.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.smoke_discharger.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.snatch_morsel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sniper_shot.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.snort.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.snowball.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.snow_cloud.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.somersault.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.somersault_kick.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1639 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.sonic_blade.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.sonic_boom.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sonic_buffet.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sonic_wave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.soporific.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.soulshattering_roar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.soul_accretion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.soul_drain.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.soul_voice.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sound_blast.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sound_vacuum.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spectral_barrier.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spider_web.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spikeball.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spike_flail.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.SUPER_BUFF) then
        return 1
    elseif mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif not target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.spinal_cleave.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.spine_lash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spinning_attack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spinning_axe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spinning_claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spinning_dive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spinning_fin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spinning_scythe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spinning_top.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spiral_hell.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spiral_spin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spirits_within.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spirit_absorption.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spirit_tap.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.spirit_vacuum.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.splash_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spoil.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spore.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spring_breeze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.spring_water.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sprout_smack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sprout_spin.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stampede.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.starburst.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.starlight.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stasis.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.static_filament.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 2 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.stave_toss.onMobSkillCheck", function(target, mob, skill)
    -- If animationSub is 1, mob has already lost the staff. If zero, still has staff.
    if
        mob:getAnimationSub() == 0 and
        (mob:getMainJob() == xi.job.BLM or mob:getMainJob() == xi.job.WHM)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.stellar_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stellar_burst.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sticky_thread.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stinking_gas.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stomping.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stone_ii.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stone_iv.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stone_meeble_warble.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stone_throw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stormwind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.strap_cutter.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.string_clipper.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stun_cannon.onMobSkillCheck", function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.sturmwind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stygian_flatus.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.stygian_vapor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sub-zero_smash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.subsonics.onMobSkillCheck", function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.substitute.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.suction.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.suctorial_tentacle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sudden_lunge.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sulfurous_breath.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.summer_breeze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.summonshadows.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.sunburst.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.super_buff.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sweep.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sweeping_flail.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.sweet_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.swift_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_enpi.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_gekko.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_goten.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_hobaku.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_jinpu.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_kagero.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_kaiten.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_kasha.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_koki.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tachi_yukikaze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tackle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tail_blow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tail_crush.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tail_roll.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tail_slap.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1643 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.tail_smash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tail_swing.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tail_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tail_whip.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.target_analysis.onMobSkillCheck", function(target, mob, skill)
    local skillList = mob:getMobMod(xi.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()

    if
        (skillList == 54 and mobhp < 26) or
        (skillList == 727 and mob:getAnimationSub() == 1)
    then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.tarutaru_warp_ii.onMobSkillCheck", function(target, mob, skill)
    return 1
end)

m:addOverride("xi.globals.mobskills.tebbad_wing.onMobSkillCheck", function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    elseif target:isBehind(mob, 96) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.tebbad_wing_air.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.tempest_wing.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 55) then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.temporal_shift.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tenebrous_mist.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()
        if mobSkin == 1805 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.tentacle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tenzen_ranged_alt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.teraflare.onMobSkillCheck", function(target, mob, skill)
    if mob:getHPP() <= 10 then
        mob:setLocalVar("TeraFlare", 0)
        mob:setMobAbilityEnabled(false) -- disable mobskills/spells until Teraflare is used successfully (don't want to delay it/queue Megaflare)
        mob:setMagicCastingEnabled(false)
        mob:setAutoAttackEnabled(false)
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.tera_slash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.terror_eye.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 4 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.terror_touch.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thermal_pulse.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 0 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.the_wrath_of_gudha.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thornsong.onMobSkillCheck", function(target, mob, skill)
    -- can only use if not silenced
    if
        mob:getMainJob() == xi.job.BRD and
        not mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.thrashing_assault.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.throat_stab.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.throat_stab_2hr.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunderbolt.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunderbolt_breath.onMobSkillCheck", function(target, mob, skill)
    -- not used in Uleguerand_Range
    if mob:getZoneID() == 5 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.thunderous_yowl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunderspark.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunderstorm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunderstrike.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1805 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.thunder_break.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunder_breath.onMobSkillCheck", function(target, mob, skill)
    if target:isInDynamis() or target:hasStatusEffect(xi.effect.BATTLEFIELD)  then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.thunder_ii.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunder_iv.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunder_maneuver.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID() + 1):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.thunder_meeble_warble.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thunder_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.thundris_shriek.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1839 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.tidal_dive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tidal_slash.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.SAM then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.tidal_wave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tormentful_glare.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.torpid_glare.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.torrent.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tortoise_song.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tortoise_stomp.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.touchdown.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.touchdown_bahamut.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tourbillion.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1805 then
            return 0
        else
            return 1
        end
    end

    --[[TODO: Khimaira should only use this when its wings are up, which is animationsub() == 0.
    There's no system to put them "down" yet, so it's not really fair to leave it active.
    Tyger's fair game, though. :)]]
    return 0
end)

m:addOverride("xi.globals.mobskills.toxic_pick.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.toxic_spit.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tp_drainkiss.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.train_fall.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.trample.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.transfusion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.transmogrification.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.trebuchet.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.trembling.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tremorous_tread.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.tremors.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tribulation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.triclip.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.trinary_absorption.onMobSkillCheck", function(target, mob, skill)
    if
        mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or
        target:hasStatusEffect(xi.effect.BATTLEFIELD)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.trinary_tap.onMobSkillCheck", function(target, mob, skill)
    if
        mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or
        mob:isMobType(xi.mobskills.mobType.BATTLEFIELD)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.triple_attack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.triumphant_roar.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 4 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.true_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.turbofan.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.turbulence.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.tusk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.twirling_dervish.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.typhoon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.typhoon_wing.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    -- animation sub 1 means flying (0 and 2 means on the ground)
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.tyrannic_blare.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ultimate_terror.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ultrasonics.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.ululation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.umbra_smash.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 1
    else
        return 0
    end
end)

m:addOverride("xi.globals.mobskills.unblessed_armor.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.unblest_jambiya.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.undead_mold.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.uppercut.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.uranos_cascade_eta.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 0 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.uranos_cascade_lambda.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 2 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.uranos_cascade_theta.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.vacuous_osculation.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vampiric_lash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vampiric_root.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vanity_dive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vanity_drive.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vanity_strike.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vapor_spray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.velocious_blade.onMobSkillCheck", function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.venom.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.venom_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.venom_shell.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.venom_spray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.venom_sting.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.venom_storm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vertical_cleave.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vertical_slash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vicious_claw.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.victory_beacon.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.victory_smite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.violent_rupture.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.viper_bite.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.viscid_emission.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.viscid_nectar.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.viscid_secretion.onMobSkillCheck", function(target, mob, skill)
    if
        mob:getName() == "Pasuk" or
        mob:getName() == "Gnyan"
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.vitriolic_barrage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vitriolic_shower.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vitriolic_spray.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.voiceless_storm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.voidsong.onMobSkillCheck", function(target, mob, skill)
    if
        mob:isInDynamis() and
        not mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return 0
    end

    -- can only used if not silenced
    if
        mob:getMainJob() == xi.job.BRD and
        not mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.void_of_repentance.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.voracious_trunk.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vorpal_blade.onMobSkillCheck", function(target, mob, skill)
    -- Check for Grah Family id 122, 123, 124
    -- if not in Paladin form, then ignore.
    if
        (mob:getFamily() == 122 or mob:getFamily() == 123 or mob:getFamily() == 124) and
        mob:getAnimationSub() ~= 1
    then
        return 1
    elseif mob:getFamily() == 176 then
        -- Handle Mamool Ja THF
        if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.THF then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.vorpal_scythe.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vorpal_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vorpal_wheel.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vortex.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulcan_shot.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulture_1.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulture_2.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulture_3.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.vulture_4.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wanion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.warcry.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.warm-up.onMobSkillCheck", function(target, mob, skill)
    -- only brown-skinned mamool should use this move
    local mobSkin = mob:getModelId()
    if mobSkin == 1639 or mobSkin == 1619 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.wasp_sting.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.water_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.water_bomb.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.water_ii.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.water_iv.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.water_maneuver.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID() + 1):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.water_meeble_warble.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.water_shield.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.water_wall.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.weapon_bash.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wheeling_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wheel_of_impregnability.onMobSkillCheck", function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        mob:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.whip_tongue.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.whirlwind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.whirl_claws.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.whirl_of_rage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.whispering_wind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.whispers_of_ire.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.whispers_of_ire_self.onMobSkillCheck", function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel ~= xi.effect.NONE then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.whistle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.white_wind.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wild_carrot.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wild_ginseng.onMobSkillCheck", function(target, mob, skill)
    if
        mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or
        mob:isMobType(xi.mobskills.mobType.BATTLEFIELD)
    then
        return 0
    end

    return 1
end)

m:addOverride("xi.globals.mobskills.wild_horn.onMobSkillCheck", function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.wild_oats.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wild_rage.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.winds_of_oblivion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.winds_of_promyvion.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wind_blade.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wind_blade2.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wind_breath.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wind_maneuver.onMobSkillCheck", function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID() + 1):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end)

m:addOverride("xi.globals.mobskills.wind_shear.onMobSkillCheck", function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1746 then
            return 0
        else
            return 1
        end
    end

    return 0
end)

m:addOverride("xi.globals.mobskills.wind_shear_znm.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wind_wall.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wings_of_gehenna.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wing_cutter.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wing_slap.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wing_thrust.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wing_whirl.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.winter_breeze.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wire_cutter.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wisecrack.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.words_of_bane.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.wz_recover_all.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.yawn.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.zephyr_arrow.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

m:addOverride("xi.globals.mobskills.zephyr_mantle.onMobSkillCheck", function(target, mob, skill)
    return 0
end)

return m
