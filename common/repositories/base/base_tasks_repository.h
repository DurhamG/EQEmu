/**
 * DO NOT MODIFY THIS FILE
 *
 * This repository was automatically generated and is NOT to be modified directly.
 * Any repository modifications are meant to be made to the repository extending the base.
 * Any modifications to base repositories are to be made by the generator only
 * 
 * @generator ./utils/scripts/generators/repository-generator.pl
 * @docs https://eqemu.gitbook.io/server/in-development/developer-area/repositories
 */

#ifndef EQEMU_BASE_TASKS_REPOSITORY_H
#define EQEMU_BASE_TASKS_REPOSITORY_H

#include "../../database.h"
#include "../../string_util.h"

class BaseTasksRepository {
public:
	struct Tasks {
		int         id;
		int         type;
		int         duration;
		int         duration_code;
		std::string title;
		std::string description;
		std::string reward;
		int         rewardid;
		int         cashreward;
		int         xpreward;
		int         rewardmethod;
		int         reward_points;
		int         reward_type;
		int         minlevel;
		int         maxlevel;
		int         repeatable;
		int         faction_reward;
		std::string completion_emote;
		int         replay_group;
		int         min_players;
		int         max_players;
		int         task_lock_step;
		int         instance_zone_id;
		int         zone_version;
		int         zone_in_zone_id;
		float       zone_in_x;
		float       zone_in_y;
		int         zone_in_object_id;
		float       dest_x;
		float       dest_y;
		float       dest_z;
		float       dest_h;
	};

	static std::string PrimaryKey()
	{
		return std::string("id");
	}

	static std::vector<std::string> Columns()
	{
		return {
			"id",
			"type",
			"duration",
			"duration_code",
			"title",
			"description",
			"reward",
			"rewardid",
			"cashreward",
			"xpreward",
			"rewardmethod",
			"reward_points",
			"reward_type",
			"minlevel",
			"maxlevel",
			"repeatable",
			"faction_reward",
			"completion_emote",
			"replay_group",
			"min_players",
			"max_players",
			"task_lock_step",
			"instance_zone_id",
			"zone_version",
			"zone_in_zone_id",
			"zone_in_x",
			"zone_in_y",
			"zone_in_object_id",
			"dest_x",
			"dest_y",
			"dest_z",
			"dest_h",
		};
	}

	static std::string ColumnsRaw()
	{
		return std::string(implode(", ", Columns()));
	}

	static std::string TableName()
	{
		return std::string("tasks");
	}

	static std::string BaseSelect()
	{
		return fmt::format(
			"SELECT {} FROM {}",
			ColumnsRaw(),
			TableName()
		);
	}

	static std::string BaseInsert()
	{
		return fmt::format(
			"INSERT INTO {} ({}) ",
			TableName(),
			ColumnsRaw()
		);
	}

	static Tasks NewEntity()
	{
		Tasks entry{};

		entry.id                = 0;
		entry.type              = 0;
		entry.duration          = 0;
		entry.duration_code     = 0;
		entry.title             = "";
		entry.description       = "";
		entry.reward            = "";
		entry.rewardid          = 0;
		entry.cashreward        = 0;
		entry.xpreward          = 0;
		entry.rewardmethod      = 2;
		entry.reward_points     = 0;
		entry.reward_type       = 0;
		entry.minlevel          = 0;
		entry.maxlevel          = 0;
		entry.repeatable        = 1;
		entry.faction_reward    = 0;
		entry.completion_emote  = "";
		entry.replay_group      = 0;
		entry.min_players       = 0;
		entry.max_players       = 0;
		entry.task_lock_step    = 0;
		entry.instance_zone_id  = 0;
		entry.zone_version      = 0;
		entry.zone_in_zone_id   = 0;
		entry.zone_in_x         = 0;
		entry.zone_in_y         = 0;
		entry.zone_in_object_id = 0;
		entry.dest_x            = 0;
		entry.dest_y            = 0;
		entry.dest_z            = 0;
		entry.dest_h            = 0;

		return entry;
	}

	static Tasks GetTasksEntry(
		const std::vector<Tasks> &taskss,
		int tasks_id
	)
	{
		for (auto &tasks : taskss) {
			if (tasks.id == tasks_id) {
				return tasks;
			}
		}

		return NewEntity();
	}

	static Tasks FindOne(
		Database& db,
		int tasks_id
	)
	{
		auto results = db.QueryDatabase(
			fmt::format(
				"{} WHERE id = {} LIMIT 1",
				BaseSelect(),
				tasks_id
			)
		);

		auto row = results.begin();
		if (results.RowCount() == 1) {
			Tasks entry{};

			entry.id                = atoi(row[0]);
			entry.type              = atoi(row[1]);
			entry.duration          = atoi(row[2]);
			entry.duration_code     = atoi(row[3]);
			entry.title             = row[4] ? row[4] : "";
			entry.description       = row[5] ? row[5] : "";
			entry.reward            = row[6] ? row[6] : "";
			entry.rewardid          = atoi(row[7]);
			entry.cashreward        = atoi(row[8]);
			entry.xpreward          = atoi(row[9]);
			entry.rewardmethod      = atoi(row[10]);
			entry.reward_points     = atoi(row[11]);
			entry.reward_type       = atoi(row[12]);
			entry.minlevel          = atoi(row[13]);
			entry.maxlevel          = atoi(row[14]);
			entry.repeatable        = atoi(row[15]);
			entry.faction_reward    = atoi(row[16]);
			entry.completion_emote  = row[17] ? row[17] : "";
			entry.replay_group      = atoi(row[18]);
			entry.min_players       = atoi(row[19]);
			entry.max_players       = atoi(row[20]);
			entry.task_lock_step    = atoi(row[21]);
			entry.instance_zone_id  = atoi(row[22]);
			entry.zone_version      = atoi(row[23]);
			entry.zone_in_zone_id   = atoi(row[24]);
			entry.zone_in_x         = static_cast<float>(atof(row[25]));
			entry.zone_in_y         = static_cast<float>(atof(row[26]));
			entry.zone_in_object_id = atoi(row[27]);
			entry.dest_x            = static_cast<float>(atof(row[28]));
			entry.dest_y            = static_cast<float>(atof(row[29]));
			entry.dest_z            = static_cast<float>(atof(row[30]));
			entry.dest_h            = static_cast<float>(atof(row[31]));

			return entry;
		}

		return NewEntity();
	}

	static int DeleteOne(
		Database& db,
		int tasks_id
	)
	{
		auto results = db.QueryDatabase(
			fmt::format(
				"DELETE FROM {} WHERE {} = {}",
				TableName(),
				PrimaryKey(),
				tasks_id
			)
		);

		return (results.Success() ? results.RowsAffected() : 0);
	}

	static int UpdateOne(
		Database& db,
		Tasks tasks_entry
	)
	{
		std::vector<std::string> update_values;

		auto columns = Columns();

		update_values.push_back(columns[0] + " = " + std::to_string(tasks_entry.id));
		update_values.push_back(columns[1] + " = " + std::to_string(tasks_entry.type));
		update_values.push_back(columns[2] + " = " + std::to_string(tasks_entry.duration));
		update_values.push_back(columns[3] + " = " + std::to_string(tasks_entry.duration_code));
		update_values.push_back(columns[4] + " = '" + EscapeString(tasks_entry.title) + "'");
		update_values.push_back(columns[5] + " = '" + EscapeString(tasks_entry.description) + "'");
		update_values.push_back(columns[6] + " = '" + EscapeString(tasks_entry.reward) + "'");
		update_values.push_back(columns[7] + " = " + std::to_string(tasks_entry.rewardid));
		update_values.push_back(columns[8] + " = " + std::to_string(tasks_entry.cashreward));
		update_values.push_back(columns[9] + " = " + std::to_string(tasks_entry.xpreward));
		update_values.push_back(columns[10] + " = " + std::to_string(tasks_entry.rewardmethod));
		update_values.push_back(columns[11] + " = " + std::to_string(tasks_entry.reward_points));
		update_values.push_back(columns[12] + " = " + std::to_string(tasks_entry.reward_type));
		update_values.push_back(columns[13] + " = " + std::to_string(tasks_entry.minlevel));
		update_values.push_back(columns[14] + " = " + std::to_string(tasks_entry.maxlevel));
		update_values.push_back(columns[15] + " = " + std::to_string(tasks_entry.repeatable));
		update_values.push_back(columns[16] + " = " + std::to_string(tasks_entry.faction_reward));
		update_values.push_back(columns[17] + " = '" + EscapeString(tasks_entry.completion_emote) + "'");
		update_values.push_back(columns[18] + " = " + std::to_string(tasks_entry.replay_group));
		update_values.push_back(columns[19] + " = " + std::to_string(tasks_entry.min_players));
		update_values.push_back(columns[20] + " = " + std::to_string(tasks_entry.max_players));
		update_values.push_back(columns[21] + " = " + std::to_string(tasks_entry.task_lock_step));
		update_values.push_back(columns[22] + " = " + std::to_string(tasks_entry.instance_zone_id));
		update_values.push_back(columns[23] + " = " + std::to_string(tasks_entry.zone_version));
		update_values.push_back(columns[24] + " = " + std::to_string(tasks_entry.zone_in_zone_id));
		update_values.push_back(columns[25] + " = " + std::to_string(tasks_entry.zone_in_x));
		update_values.push_back(columns[26] + " = " + std::to_string(tasks_entry.zone_in_y));
		update_values.push_back(columns[27] + " = " + std::to_string(tasks_entry.zone_in_object_id));
		update_values.push_back(columns[28] + " = " + std::to_string(tasks_entry.dest_x));
		update_values.push_back(columns[29] + " = " + std::to_string(tasks_entry.dest_y));
		update_values.push_back(columns[30] + " = " + std::to_string(tasks_entry.dest_z));
		update_values.push_back(columns[31] + " = " + std::to_string(tasks_entry.dest_h));

		auto results = db.QueryDatabase(
			fmt::format(
				"UPDATE {} SET {} WHERE {} = {}",
				TableName(),
				implode(", ", update_values),
				PrimaryKey(),
				tasks_entry.id
			)
		);

		return (results.Success() ? results.RowsAffected() : 0);
	}

	static Tasks InsertOne(
		Database& db,
		Tasks tasks_entry
	)
	{
		std::vector<std::string> insert_values;

		insert_values.push_back(std::to_string(tasks_entry.id));
		insert_values.push_back(std::to_string(tasks_entry.type));
		insert_values.push_back(std::to_string(tasks_entry.duration));
		insert_values.push_back(std::to_string(tasks_entry.duration_code));
		insert_values.push_back("'" + EscapeString(tasks_entry.title) + "'");
		insert_values.push_back("'" + EscapeString(tasks_entry.description) + "'");
		insert_values.push_back("'" + EscapeString(tasks_entry.reward) + "'");
		insert_values.push_back(std::to_string(tasks_entry.rewardid));
		insert_values.push_back(std::to_string(tasks_entry.cashreward));
		insert_values.push_back(std::to_string(tasks_entry.xpreward));
		insert_values.push_back(std::to_string(tasks_entry.rewardmethod));
		insert_values.push_back(std::to_string(tasks_entry.reward_points));
		insert_values.push_back(std::to_string(tasks_entry.reward_type));
		insert_values.push_back(std::to_string(tasks_entry.minlevel));
		insert_values.push_back(std::to_string(tasks_entry.maxlevel));
		insert_values.push_back(std::to_string(tasks_entry.repeatable));
		insert_values.push_back(std::to_string(tasks_entry.faction_reward));
		insert_values.push_back("'" + EscapeString(tasks_entry.completion_emote) + "'");
		insert_values.push_back(std::to_string(tasks_entry.replay_group));
		insert_values.push_back(std::to_string(tasks_entry.min_players));
		insert_values.push_back(std::to_string(tasks_entry.max_players));
		insert_values.push_back(std::to_string(tasks_entry.task_lock_step));
		insert_values.push_back(std::to_string(tasks_entry.instance_zone_id));
		insert_values.push_back(std::to_string(tasks_entry.zone_version));
		insert_values.push_back(std::to_string(tasks_entry.zone_in_zone_id));
		insert_values.push_back(std::to_string(tasks_entry.zone_in_x));
		insert_values.push_back(std::to_string(tasks_entry.zone_in_y));
		insert_values.push_back(std::to_string(tasks_entry.zone_in_object_id));
		insert_values.push_back(std::to_string(tasks_entry.dest_x));
		insert_values.push_back(std::to_string(tasks_entry.dest_y));
		insert_values.push_back(std::to_string(tasks_entry.dest_z));
		insert_values.push_back(std::to_string(tasks_entry.dest_h));

		auto results = db.QueryDatabase(
			fmt::format(
				"{} VALUES ({})",
				BaseInsert(),
				implode(",", insert_values)
			)
		);

		if (results.Success()) {
			tasks_entry.id = results.LastInsertedID();
			return tasks_entry;
		}

		tasks_entry = NewEntity();

		return tasks_entry;
	}

	static int InsertMany(
		Database& db,
		std::vector<Tasks> tasks_entries
	)
	{
		std::vector<std::string> insert_chunks;

		for (auto &tasks_entry: tasks_entries) {
			std::vector<std::string> insert_values;

			insert_values.push_back(std::to_string(tasks_entry.id));
			insert_values.push_back(std::to_string(tasks_entry.type));
			insert_values.push_back(std::to_string(tasks_entry.duration));
			insert_values.push_back(std::to_string(tasks_entry.duration_code));
			insert_values.push_back("'" + EscapeString(tasks_entry.title) + "'");
			insert_values.push_back("'" + EscapeString(tasks_entry.description) + "'");
			insert_values.push_back("'" + EscapeString(tasks_entry.reward) + "'");
			insert_values.push_back(std::to_string(tasks_entry.rewardid));
			insert_values.push_back(std::to_string(tasks_entry.cashreward));
			insert_values.push_back(std::to_string(tasks_entry.xpreward));
			insert_values.push_back(std::to_string(tasks_entry.rewardmethod));
			insert_values.push_back(std::to_string(tasks_entry.reward_points));
			insert_values.push_back(std::to_string(tasks_entry.reward_type));
			insert_values.push_back(std::to_string(tasks_entry.minlevel));
			insert_values.push_back(std::to_string(tasks_entry.maxlevel));
			insert_values.push_back(std::to_string(tasks_entry.repeatable));
			insert_values.push_back(std::to_string(tasks_entry.faction_reward));
			insert_values.push_back("'" + EscapeString(tasks_entry.completion_emote) + "'");
			insert_values.push_back(std::to_string(tasks_entry.replay_group));
			insert_values.push_back(std::to_string(tasks_entry.min_players));
			insert_values.push_back(std::to_string(tasks_entry.max_players));
			insert_values.push_back(std::to_string(tasks_entry.task_lock_step));
			insert_values.push_back(std::to_string(tasks_entry.instance_zone_id));
			insert_values.push_back(std::to_string(tasks_entry.zone_version));
			insert_values.push_back(std::to_string(tasks_entry.zone_in_zone_id));
			insert_values.push_back(std::to_string(tasks_entry.zone_in_x));
			insert_values.push_back(std::to_string(tasks_entry.zone_in_y));
			insert_values.push_back(std::to_string(tasks_entry.zone_in_object_id));
			insert_values.push_back(std::to_string(tasks_entry.dest_x));
			insert_values.push_back(std::to_string(tasks_entry.dest_y));
			insert_values.push_back(std::to_string(tasks_entry.dest_z));
			insert_values.push_back(std::to_string(tasks_entry.dest_h));

			insert_chunks.push_back("(" + implode(",", insert_values) + ")");
		}

		std::vector<std::string> insert_values;

		auto results = db.QueryDatabase(
			fmt::format(
				"{} VALUES {}",
				BaseInsert(),
				implode(",", insert_chunks)
			)
		);

		return (results.Success() ? results.RowsAffected() : 0);
	}

	static std::vector<Tasks> All(Database& db)
	{
		std::vector<Tasks> all_entries;

		auto results = db.QueryDatabase(
			fmt::format(
				"{}",
				BaseSelect()
			)
		);

		all_entries.reserve(results.RowCount());

		for (auto row = results.begin(); row != results.end(); ++row) {
			Tasks entry{};

			entry.id                = atoi(row[0]);
			entry.type              = atoi(row[1]);
			entry.duration          = atoi(row[2]);
			entry.duration_code     = atoi(row[3]);
			entry.title             = row[4] ? row[4] : "";
			entry.description       = row[5] ? row[5] : "";
			entry.reward            = row[6] ? row[6] : "";
			entry.rewardid          = atoi(row[7]);
			entry.cashreward        = atoi(row[8]);
			entry.xpreward          = atoi(row[9]);
			entry.rewardmethod      = atoi(row[10]);
			entry.reward_points     = atoi(row[11]);
			entry.reward_type       = atoi(row[12]);
			entry.minlevel          = atoi(row[13]);
			entry.maxlevel          = atoi(row[14]);
			entry.repeatable        = atoi(row[15]);
			entry.faction_reward    = atoi(row[16]);
			entry.completion_emote  = row[17] ? row[17] : "";
			entry.replay_group      = atoi(row[18]);
			entry.min_players       = atoi(row[19]);
			entry.max_players       = atoi(row[20]);
			entry.task_lock_step    = atoi(row[21]);
			entry.instance_zone_id  = atoi(row[22]);
			entry.zone_version      = atoi(row[23]);
			entry.zone_in_zone_id   = atoi(row[24]);
			entry.zone_in_x         = static_cast<float>(atof(row[25]));
			entry.zone_in_y         = static_cast<float>(atof(row[26]));
			entry.zone_in_object_id = atoi(row[27]);
			entry.dest_x            = static_cast<float>(atof(row[28]));
			entry.dest_y            = static_cast<float>(atof(row[29]));
			entry.dest_z            = static_cast<float>(atof(row[30]));
			entry.dest_h            = static_cast<float>(atof(row[31]));

			all_entries.push_back(entry);
		}

		return all_entries;
	}

	static std::vector<Tasks> GetWhere(Database& db, std::string where_filter)
	{
		std::vector<Tasks> all_entries;

		auto results = db.QueryDatabase(
			fmt::format(
				"{} WHERE {}",
				BaseSelect(),
				where_filter
			)
		);

		all_entries.reserve(results.RowCount());

		for (auto row = results.begin(); row != results.end(); ++row) {
			Tasks entry{};

			entry.id                = atoi(row[0]);
			entry.type              = atoi(row[1]);
			entry.duration          = atoi(row[2]);
			entry.duration_code     = atoi(row[3]);
			entry.title             = row[4] ? row[4] : "";
			entry.description       = row[5] ? row[5] : "";
			entry.reward            = row[6] ? row[6] : "";
			entry.rewardid          = atoi(row[7]);
			entry.cashreward        = atoi(row[8]);
			entry.xpreward          = atoi(row[9]);
			entry.rewardmethod      = atoi(row[10]);
			entry.reward_points     = atoi(row[11]);
			entry.reward_type       = atoi(row[12]);
			entry.minlevel          = atoi(row[13]);
			entry.maxlevel          = atoi(row[14]);
			entry.repeatable        = atoi(row[15]);
			entry.faction_reward    = atoi(row[16]);
			entry.completion_emote  = row[17] ? row[17] : "";
			entry.replay_group      = atoi(row[18]);
			entry.min_players       = atoi(row[19]);
			entry.max_players       = atoi(row[20]);
			entry.task_lock_step    = atoi(row[21]);
			entry.instance_zone_id  = atoi(row[22]);
			entry.zone_version      = atoi(row[23]);
			entry.zone_in_zone_id   = atoi(row[24]);
			entry.zone_in_x         = static_cast<float>(atof(row[25]));
			entry.zone_in_y         = static_cast<float>(atof(row[26]));
			entry.zone_in_object_id = atoi(row[27]);
			entry.dest_x            = static_cast<float>(atof(row[28]));
			entry.dest_y            = static_cast<float>(atof(row[29]));
			entry.dest_z            = static_cast<float>(atof(row[30]));
			entry.dest_h            = static_cast<float>(atof(row[31]));

			all_entries.push_back(entry);
		}

		return all_entries;
	}

	static int DeleteWhere(Database& db, std::string where_filter)
	{
		auto results = db.QueryDatabase(
			fmt::format(
				"DELETE FROM {} WHERE {}",
				TableName(),
				where_filter
			)
		);

		return (results.Success() ? results.RowsAffected() : 0);
	}

	static int Truncate(Database& db)
	{
		auto results = db.QueryDatabase(
			fmt::format(
				"TRUNCATE TABLE {}",
				TableName()
			)
		);

		return (results.Success() ? results.RowsAffected() : 0);
	}

};

#endif //EQEMU_BASE_TASKS_REPOSITORY_H