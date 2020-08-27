#ifndef _GAMBITSCONTAINER
#define _GAMBITSCONTAINER

#include "../../../common/cbasetypes.h"
#include "../../entities/charentity.h"
#include "../../entities/trustentity.h"
#include "../ai_container.h"
#include "../controllers/trust_controller.h"
#include "../../mob_spell_container.h"
#include "../../status_effect.h"
#include "../../status_effect_container.h"

namespace gambits
{

enum class G_TARGET : uint16
{
    SELF   = 0,
    PARTY  = 1,
    TARGET = 2,
    MASTER = 3,
    TANK   = 4,
};

enum class G_CONDITION : uint16
{
    ALWAYS             = 0,
    HPP_LT             = 1,
    HPP_GTE            = 2,
    MPP_LT             = 3,
    TP_LT              = 4,
    TP_GTE             = 5,
    STATUS             = 6,
    NOT_STATUS         = 7,
    STATUS_FLAG        = 8,
    HAS_TOP_ENMITY     = 9,
    NOT_HAS_TOP_ENMITY = 10,
    SC_AVAILABLE       = 11,
    NOT_SC_AVAILABLE   = 12,
    MB_AVAILABLE       = 13,
    READYING_WS        = 14,
    READYING_MS        = 15,
    READYING_JA        = 16,
    CASTING_MA         = 17,
    RANDOM             = 18,
};

enum class G_REACTION : uint16
{
    ATTACK = 0,
    ASSIST = 1,
    MA     = 2,
    JA     = 3,
    WS     = 4,
    MS     = 5,
    MSG    = 6,
};

enum class G_SELECT : uint16
{
    HIGHEST    = 0,
    LOWEST     = 1,
    SPECIFIC   = 2,
    RANDOM     = 3,
    MB_ELEMENT = 4,
    SPECIAL_AYAME = 5,
};

enum class G_TP_TRIGGER : uint16
{
    ASAP = 0,
    RANDOM = 1,
    OPENER = 2,
    CLOSER = 3,
};

struct Predicate_t
{
    G_TARGET target;
    G_CONDITION condition;
    uint32 condition_arg = 0;

    bool parseInput(std::string key, uint32 value)
    {
        if (key.compare("target") == 0)
        {
            target = static_cast<G_TARGET>(value);
        }
        else if (key.compare("condition") == 0)
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

struct Action_t
{
    G_REACTION reaction;
    G_SELECT select;
    uint32 select_arg = 0;

    bool parseInput(std::string key, uint32 value)
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
    std::vector<Predicate_t> predicates;
    std::vector<Action_t> actions;
    uint16 retry_delay = 0;
    time_point last_used;
};

// TODO
struct Chain_t
{
    std::vector<Gambit_t> gambits;
};

// TODO: smaller types, make less bad.
struct TrustSkill_t
{
    G_REACTION skill_type;
    uint32 skill_id;
    uint32 min_level;
    uint8 primary;
    uint8 secondary;
    uint8 tertiary;
};

class CGambitsContainer
{
public:
    CGambitsContainer(CTrustEntity* trust) : POwner(trust) {}
    ~CGambitsContainer() = default;

    void AddGambit(Gambit_t gambit);
    void Tick(time_point tick);

    // TODO: make private
    std::vector<TrustSkill_t> tp_skills;
    G_TP_TRIGGER tp_trigger;
    G_SELECT tp_select;

private:
    bool CheckTrigger(CBattleEntity* trigger_target, Predicate_t& predicate);
    bool TryTrustSkill();

    CTrustEntity* POwner;
    time_point m_lastAction;
    std::vector<Gambit_t> gambits;
};

} // namespace gambits

#endif // _GAMBITSCONTAINER
