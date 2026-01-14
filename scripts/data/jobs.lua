-----------------------------------
-- Tables defining diferent elemental caracteristics.
-- Ordered by element ID.
-----------------------------------
xi = xi or {}
xi.data = xi.data or {}
xi.data.job = xi.data.job or {}
-----------------------------------

local column =
{
    INNATE_CASTING = 1,
}

xi.data.job.dataTable =
{
    [xi.job.WAR] = { false },
    [xi.job.MNK] = { false },
    [xi.job.WHM] = { true  },
    [xi.job.BLM] = { true  },
    [xi.job.RDM] = { true  },
    [xi.job.THF] = { false },
    [xi.job.PLD] = { true  },
    [xi.job.DRK] = { true  },
    [xi.job.BST] = { false },
    [xi.job.BRD] = { true  },
    [xi.job.RNG] = { false },
    [xi.job.SAM] = { false },
    [xi.job.NIN] = { true  },
    [xi.job.DRG] = { false },
    [xi.job.SMN] = { true  },
    [xi.job.BLU] = { true  },
    [xi.job.COR] = { false },
    [xi.job.PUP] = { false },
    [xi.job.DNC] = { false },
    [xi.job.SCH] = { true  },
    [xi.job.GEO] = { true  },
    [xi.job.RUN] = { true  },
}

xi.data.job.isInnateCaster = function(target)
    local mainJob = target:getMainJob()
    local subjob  = target:getSubJob()

    if
        xi.data.job.dataTable[mainJob][column.INNATE_CASTING] or
        xi.data.job.dataTable[subjob][column.INNATE_CASTING]
    then
        return true
    end

    return false
end
