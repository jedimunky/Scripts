ALTER TABLE HI.TH514_REBATE_PCENT
   ADD COLUMN WHOLE_REBATE_LEVEL DECIMAL (2, 0) NOT NULL DEFAULT 0;

REORG TABLE HI.TH514_REBATE_PCENT
  KEEPDICTIONARY;

RUNSTATS ON TABLE HI.TH514_REBATE_PCENT
  ON ALL COLUMNS;