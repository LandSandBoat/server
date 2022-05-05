#include "sql_prepared_stmt.h"

#include "logging.h"
#include <vector>

SqlPreparedStatement::SqlPreparedStatement(MYSQL* handle, std::string const& query)
{
    m_Statement = mysql_stmt_init(handle);
    if (m_Statement == nullptr)
    {
        ShowError("mysql_stmt_init: %s", mysql_stmt_error(m_Statement));
        std::exit(-1);
    }

    auto res = mysql_stmt_prepare(m_Statement, query.c_str(), static_cast<unsigned long>(query.size()));
    if (res != 0)
    {
        ShowError("mysql_stmt_prepare: %s", mysql_stmt_error(m_Statement));
        std::exit(-1);
    }

    std::size_t fieldCount = mysql_stmt_field_count(m_Statement);
    std::size_t paramCount = mysql_stmt_param_count(m_Statement);

    m_Fields = std::vector<MYSQL_BIND>(fieldCount);
    m_Params = std::vector<MYSQL_BIND>(paramCount);
}

SqlPreparedStatement::~SqlPreparedStatement()
{
    mysql_stmt_close(m_Statement);
}

void SqlPreparedStatement::Execute()
{
    // TODO
}
