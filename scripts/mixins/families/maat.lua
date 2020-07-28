require("scripts/globals/mixins")
require("scripts/globals/status")


g_mixins = g_mixins or {}

g_mixins.maat = function(mob)

    mob:addListener("SPAWN", "JOB_SPECIAL_SPAWN", function(mob)
        if (mob:getMainJob() == tpz.job.NIN) then
            mob:setLocalVar("specialThreshold", 40)
        elseif (mob:getMainJob() == tpz.job.DRG) then
            mob:setLocalVar("specialThreshold", 75)
        else
            mob:setLocalVar("specialThreshold", math.random(50, 60))
        end
    end)

    mob:addListener("ROAM_TICK", "MAAT_RTICK", function(mob)
        if mob:getLocalVar("engaged") == 0 then
            for _, player in pairs(mob:getZone():getPlayers()) do
                if player:checkDistance(mob) < 8 then
                    local ID = zones[mob:getZoneID()]
                    mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
                    mob:setLocalVar("engaged", player:getID())
                end
            end
        end
    end)

    mob:addListener("ENGAGE", "MAAT_ENGAGE", function(mob, target)
        if mob:getLocalVar("engaged") == 0 then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
            mob:setLocalVar("engaged", target:getID())
        end
    end)

    mob:addListener("DISENGAGE", "MAAT_DISENGAGE", function(mob)
        engagedID = mob:getLocalVar("engaged")
        if engagedID ~= 0 then
            player = GetPlayerByID(engagedID)
            if player:getHP() == 0 then
                local ID = zones[mob:getZoneID()]
                mob:showText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
            end
        end
    end)

    mob:addListener("COMBAT_TICK", "MAAT_CTICK", function(mob)
        local defaultAbility =
        {
            [tpz.job.WAR] = tpz.jsa.MIGHTY_STRIKES_MAAT,
            [tpz.job.MNK] = tpz.jsa.HUNDRED_FISTS_MAAT,
            [tpz.job.WHM] = tpz.jsa.BENEDICTION_MAAT,
            [tpz.job.BLM] = tpz.jsa.MANAFONT_MAAT,
            [tpz.job.RDM] = tpz.jsa.CHAINSPELL_MAAT,
            [tpz.job.THF] = tpz.jsa.PERFECT_DODGE_MAAT,
            [tpz.job.PLD] = tpz.jsa.INVINCIBLE_MAAT,
            [tpz.job.DRK] = tpz.jsa.BLOOD_WEAPON_MAAT,
            [tpz.job.BST] = tpz.jsa.FAMILIAR_MAAT,
            [tpz.job.BRD] = tpz.jsa.SOUL_VOICE_MAAT,
            [tpz.job.RNG] = tpz.jsa.EES_MAAT,
            [tpz.job.SAM] = tpz.jsa.MEIKYO_SHISUI_MAAT,
            [tpz.job.NIN] = tpz.jsa.MIJIN_GAKURE_MAAT,
            [tpz.job.DRG] = tpz.jsa.CALL_WYVERN_MAAT,
            [tpz.job.SMN] = tpz.jsa.ASTRAL_FLOW_MAAT,
        }

        if mob:getHPP() < mob:getLocalVar("specialThreshold") then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.NOW_THAT_IM_WARMED_UP)
            mob:useMobAbility(defaultAbility[mob:getMainJob()])
            mob:setLocalVar("specialThreshold", 0)
        end

        if mob:getHPP() < 20 or (mob:getMainJob() == tpz.job.WHM and mob:getBattleTime() > 300) then
            local ID = zones[mob:getZoneID()]
            mob:showText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
            mob:getBattlefield():win()
        end

    end)

    mob:addListener("ITEM_STOLEN", "MAAT_ITEM_STOLEN", function(mob, player, itemId)
        if mob:getMainJob() == tpz.job.THF then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
            mob:getBattlefield():win()
        end
    end)

    mob:addListener("DEATH", "MAAT_DEATH", function(mob, killer)
        local ID = zones[mob:getZoneID()]
        mob:messageText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
    end)

    mob:addListener("WEAPONSKILL_TAKE", "MAAT_WEAPONSKILL_TAKE", function(target, user, wsid, tp, action)
        local ID = zones[target:getZoneID()]
        target:messageText(target, ID.text.THAT_LL_HURT_IN_THE_MORNING)
    end)

    mob:addListener("WEAPONSKILL_USE", "MAAT_WEAPONSKILL_USE", function(mob, target, wsid, tp, action)
        local ID = zones[mob:getZoneID()]
        if (wsid == 1028) then -- Tackle
            mob:messageText(mob, ID.text.TAKE_THAT_YOU_WHIPPERSNAPPER)
        elseif (wsid == 1033) then -- Dragon Kick
            mob:messageText(mob, ID.text.TEACH_YOU_TO_RESPECT_ELDERS)
        elseif (wsid == 1034) then -- Asuran Fists
            mob:messageText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
        end
    end)

end

return g_mixins.maat
