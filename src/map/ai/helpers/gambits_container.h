/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

#include "ai/ai_container.h"
#include "ai/controllers/trust_controller.h"
#include "common/cbasetypes.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "mob_spell_container.h"
#include "status_effect.h"
#include "status_effect_container.h"

#include <set>
#include <utility>

namespace gambits
{

enum class G_TARGET : uint16
{
    SELF                       = 0,
    PARTY                      = 1,
    TARGET                     = 2,
    MASTER                     = 3,
    TANK                       = 4,
    MELEE                      = 5,
    RANGED                     = 6,
    CASTER                     = 7,
    TOP_ENMITY                 = 8,
    CURILLA                    = 9, // Special case for Rainemard
    PARTY_DEAD                 = 10,
    PARTY_MULTI                = 11,
    TRIGGER_SELF_ACTION_TARGET = 12,
    TRIGGER_TARGET_ACTION_SELF = 13,
};

enum class G_LOGIC : uint16
{
    AND = 0,
    OR  = 1,
};

enum class G_CONDITION : uint16
{
    ALWAYS             = 0,
    HPP_LT             = 1,
    HPP_GTE            = 2,
    MPP_LT             = 3,
    MPP_GTE            = 4,
    TP_LT              = 5,
    TP_GTE             = 6,
    LVL_LT             = 7,
    LVL_GTE            = 8,
    STATUS             = 9,
    NOT_STATUS         = 10,
    STATUS_FLAG        = 11,
    HAS_TOP_ENMITY     = 12,
    NOT_HAS_TOP_ENMITY = 13,
    SC_AVAILABLE       = 14,
    NOT_SC_AVAILABLE   = 15,
    MB_AVAILABLE       = 16,
    READYING_WS        = 17,
    READYING_MS        = 18,
    READYING_JA        = 19,
    CASTING_MA         = 20,
    RANDOM             = 21,
    NO_SAMBA           = 22,
    NO_STORM           = 23,
    PT_HAS_TANK        = 24,
    NOT_PT_HAS_TANK    = 25,
    IS_ECOSYSTEM       = 26,
    HP_MISSING         = 27,
    CASTING_ELEMENT_MA = 28,
    CAST_ELE_MA_SELF   = 29,
    CASTING_ELE_MA_AOE = 30,
    NEED_ELE_BAREFFECT = 31,
    NO_MAX_RUNE        = 32,
    HAS_RUNES          = 33,
    LUNGE_MB_AVAILABLE = 34,
    SUB_ANIMATION      = 35,
};

enum class G_REACTION : uint16
{
    ATTACK  = 0,
    RATTACK = 1,
    MA      = 2,
    JA      = 3,
    WS      = 4,
    MS      = 5,
};

enum class G_SELECT : uint16
{
    HIGHEST             = 0,
    LOWEST              = 1,
    SPECIFIC            = 2,
    RANDOM              = 3,
    MB_ELEMENT          = 4,
    SPECIAL_AYAME       = 5,
    SPECIAL_AUGUST      = 6,
    BEST_AGAINST_TARGET = 7,
    BEST_SAMBA          = 8,
    HIGHEST_WALTZ       = 9,
    ENTRUSTED           = 10,
    BEST_INDI           = 11,
    STORM_DAY           = 12,
    HELIX_DAY           = 13,
    EN_MOB_WEAKNESS     = 14,
    STORM_MOB_WEAKNESS  = 15,
    HELIX_MOB_WEAKNESS  = 16,
    DEF_BAR_ELEMENT     = 17,
    RUNE_DAY            = 18,
};

enum class G_TP_TRIGGER : uint16
{
    ASAP            = 0,
    RANDOM          = 1,
    OPENER          = 2,
    CLOSER          = 3, // Will Hold TP Indefinitely to close a SC
    CLOSER_UNTIL_TP = 4, // Will Hold TP to close a SC until a certain threshold
};

struct Predicate_t
{
    G_CONDITION condition;
    uint32      condition_arg;

    Predicate_t()
    : condition_arg(0)
    {
    }

    Predicate_t(G_CONDITION _condition, uint32 _condition_arg)
    : condition(_condition)
    , condition_arg(_condition_arg)
    {
    }

    bool parseInput(const std::string& key, uint32 value)
    {
        if (key.compare("condition") == 0)
        {
            condition = static_cast<G_CONDITION>(value);
        }
        else if (key.compare("argument") == 0)
        {
            condition_arg = value;
        }
        else
        {
            // TODO: Log error
            return false;
        }
        return true;
    }
};

struct PredicateGroup_t
{
    G_LOGIC                  logic;
    std::vector<Predicate_t> predicates;

    PredicateGroup_t(G_LOGIC _logic, std::vector<Predicate_t> _predicates)
    : logic(_logic)
    , predicates(std::move(_predicates))
    {
    }
};

struct Action_t
{
    G_REACTION reaction;
    G_SELECT   select;
    uint32     select_arg = 0;

    Action_t(G_REACTION reaction, G_SELECT select, uint32 select_arg)
    : reaction(reaction)
    , select(select)
    , select_arg(select_arg)
    {
    }

    bool parseInput(const std::string& key, uint32 value)
    {
        if (key.compare("reaction") == 0)
        {
            reaction = static_cast<G_REACTION>(value);
        }
        else if (key.compare("select") == 0)
        {
            select = static_cast<G_SELECT>(value);
        }
        else if (key.compare("argument") == 0)
        {
            select_arg = value;
        }
        else
        {
            // TODO: Log error
            return false;
        }
        return true;
    }
};

struct Gambit_t
{
    std::vector<PredicateGroup_t> predicate_groups;
    std::vector<Action_t>         actions;
    G_TARGET                      target_selector;
    uint16                        retry_delay;
    timer::time_point             last_used;
    std::string                   identifier;

    Gambit_t()
    : retry_delay(0)
    {
    }
};

// TODO
struct Chain_t
{
    std::vector<Gambit_t> gambits;

    Chain_t()
    {
    }
};

// TODO: smaller types, make less bad.
struct TrustSkill_t
{
    G_REACTION skill_type;
    uint32     skill_id;
    uint8      primary;
    uint8      secondary;
    uint8      tertiary;
    TARGETTYPE valid_targets;

    TrustSkill_t()
    : skill_id(0)
    , primary(0)
    , secondary(0)
    , tertiary(0)
    {
    }

    TrustSkill_t(G_REACTION _skill_type, uint32 _skill_id, uint8 _primary, uint8 _secondary, uint8 _tertiary, TARGETTYPE _valid_targets)
    : skill_type(_skill_type)
    , skill_id(_skill_id)
    , primary(_primary)
    , secondary(_secondary)
    , tertiary(_tertiary)
    , valid_targets(_valid_targets)
    {
    }
};

class CGambitsContainer
{
public:
    CGambitsContainer(CTrustEntity* trust)
    : POwner(trust)
    {
    }
    ~CGambitsContainer() = default;

    auto NewGambitIdentifier(const Gambit_t& gambit) const -> std::string;
    auto AddGambit(const Gambit_t& gambit) -> std::string;
    void RemoveGambit(const std::string& id);
    void RemoveAllGambits();
    auto Tick(timer::time_point tick) -> Task<void>;

    // TODO: make private
    std::vector<TrustSkill_t> tp_skills;
    G_TP_TRIGGER              tp_trigger;
    G_SELECT                  tp_select;
    uint16                    tp_value;

private:
    bool CheckTrigger(const CBattleEntity* triggerTarget, PredicateGroup_t& predicateGroup);
    bool TryTrustSkill();
    bool PartyHasHealer();
    bool PartyHasTank();

    CTrustEntity*         POwner;
    timer::time_point     m_lastAction;
    std::vector<Gambit_t> gambits;

    std::set<JOBTYPE> melee_jobs = {
        JOB_WAR,
        JOB_MNK,
        JOB_THF,
        JOB_PLD,
        JOB_DRK,
        JOB_BST,
        JOB_SAM,
        JOB_NIN,
        JOB_DRG,
        JOB_BLU,
        JOB_PUP,
        JOB_DNC,
        JOB_RUN,
    };

    std::set<JOBTYPE> caster_jobs = {
        JOB_WHM,
        JOB_BLM,
        JOB_RDM,
        JOB_BRD,
        JOB_SMN,
        JOB_BLU,
        JOB_SCH,
        JOB_GEO,
        JOB_RUN,
    };
};

} // namespace gambits
