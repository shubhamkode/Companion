const tableCreateQueries = [
  """
CREATE TABLE IF NOT EXISTS contact (
	id VARCHAR(8) PRIMARY KEY,
	name TEXT NOT NULL,
	distributor TEXT NOT NULL,
	created DATETIME,
	hexColor VARCHAR(10)  NOT NULL
	);
	""",
  """
CREATE TABLE IF NOT EXISTS company (
	id VARCHAR(8) PRIMARY KEY,
	name TEXT NOT NULL,
	description TEXT NOT NULL,
  hexColor VARCHAR(10) NOT NULL
	);

""",
  """
CREATE TABLE IF NOT EXISTS pim (
	id VARCHAR(8) PRIMARY KEY,
	digits VARCHAR(10) NOT NULL,
  created DATETIME,
	contact_id VARCHAR(8),
	FOREIGN KEY(contact_id) REFERENCES contact(id)
	);
	
  """,
  """
CREATE TABLE IF NOT EXISTS company_to_contact (
	id VARCHAR(8) PRIMARY KEY,
	company_id VARCHAR(8) NOT NULL,
	contact_id VARCHAR(8) NOT NULL,
	FOREIGN KEY (company_id) REFERENCES company(id),
	FOREIGN KEY (contact_id) REFERENCES contact(id)
	);
"""
];
