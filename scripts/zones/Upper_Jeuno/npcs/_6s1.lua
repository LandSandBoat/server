-----------------------------------
-- Area: Upper Jeuno
--  NPC: Door: "Marble Bridge"
-- !pos -96 -0.2 92 244
-----------------------------------
---@type TNpcEntity
local entity = {}

local checkType =
{
    NATION = 1,
    JOB    = 2,
    RACE   = 3,
}

local welcomeSchedule =
{
    [ 1] = { check = checkType.NATION, value  = xi.nation.SANDORIA },
    [ 2] = { check = checkType.NATION, value  = xi.nation.BASTOK   },
    [ 3] = { check = checkType.NATION, value  = xi.nation.WINDURST },
    [ 4] = { check = checkType.JOB,    value  = xi.job.WAR },
    [ 5] = { check = checkType.JOB,    value  = xi.job.MNK },
    [ 6] = { check = checkType.JOB,    value  = xi.job.WHM },
    [ 7] = { check = checkType.JOB,    value  = xi.job.BLM },
    [ 8] = { check = checkType.JOB,    value  = xi.job.RDM },
    [ 9] = { check = checkType.JOB,    value  = xi.job.THF },
    [10] = { check = checkType.JOB,    value  = xi.job.PLD },
    [11] = { check = checkType.JOB,    value  = xi.job.DRK },
    [12] = { check = checkType.JOB,    value  = xi.job.BST },
    [13] = { check = checkType.JOB,    value  = xi.job.BRD },
    [14] = { check = checkType.JOB,    value  = xi.job.RNG },
    [15] = { check = checkType.JOB,    value  = xi.job.SAM },
    [16] = { check = checkType.JOB,    value  = xi.job.NIN },
    [17] = { check = checkType.JOB,    value  = xi.job.DRG },
    [18] = { check = checkType.JOB,    value  = xi.job.SMN },
    [19] = { check = checkType.JOB,    value  = xi.job.BLU },
    [20] = { check = checkType.JOB,    value  = xi.job.COR },
    [21] = { check = checkType.JOB,    value  = xi.job.PUP },
    [22] = { check = checkType.JOB,    value  = xi.job.DNC },
    [23] = { check = checkType.JOB,    value  = xi.job.SCH },
    [24] = { check = checkType.JOB,    value  = xi.job.GEO },
    [25] = { check = checkType.JOB,    value  = xi.job.RUN },
    [26] = { check = checkType.RACE,   values = { xi.race.HUME_M,   xi.race.HUME_F   } },
    [27] = { check = checkType.RACE,   values = { xi.race.ELVAAN_M, xi.race.ELVAAN_F } },
    [28] = { check = checkType.RACE,   values = { xi.race.TARU_M,   xi.race.TARU_F   } },
    [29] = { check = checkType.RACE,   values = { xi.race.MITHRA                     } },
    [30] = { check = checkType.RACE,   values = { xi.race.GALKA                      } },
    [31] = { check = checkType.RACE,   values = { xi.race.HUME_M, xi.race.ELVAAN_M, xi.race.TARU_M, xi.race.GALKA  } }, -- Male
    [32] = { check = checkType.RACE,   values = { xi.race.HUME_F, xi.race.ELVAAN_F, xi.race.TARU_F, xi.race.MITHRA } }, -- Female
}

entity.onSpawn = function(npc)
    -- Closing time triggers at Vana'diel midnight.
    npc:addPeriodicTrigger(0, 1440, 0)
end

entity.onTimeTrigger = function(npc, triggerID)
    for _, player in pairs(npc:getZone():getPlayers()) do
        if
            player:isPlayerInTriggerArea(1) or
            player:isPlayerInTriggerArea(2)
        then
            player:startEvent(127)
        end
    end
end

entity.onTrigger = function(player, npc)
    local welcomedIndex = VanadielUniqueDay() % #welcomeSchedule
    local today         = welcomeSchedule[welcomedIndex + 1]
    local welcome       = 0

    switch(today.check): caseof
    {
        [checkType.NATION] = function()
            if today.value == player:getNation() then
                welcome = 1
            end
        end,

        [checkType.JOB] = function()
            if today.value == player:getMainJob() then
                welcome = 1
            end
        end,

        [checkType.RACE] = function()
            if utils.contains(player:getRace(), today.values) then
                welcome = 1
            end
        end,
    }

    player:startEvent(124, welcomedIndex, welcome)
end

return entity
