--  Copyrights     : CNRS
--  Author         : Oleg Lodygensky
--  Acknowledgment : XtremWeb-HEP is based on XtremWeb 1.8.0 by inria : http://www.xtremweb.net/
--  Web            : http://www.xtremweb-hep.org
-- 
--       This file is part of XtremWeb-HEP.
-- 
--     XtremWeb-HEP is free software: you can redistribute it and/or modify
--     it under the terms of the GNU General Public License as published by
--     the Free Software Foundation, either version 3 of the License, or
--     (at your option) any later version.
-- 
--     XtremWeb-HEP is distributed in the hope that it will be useful,
--     but WITHOUT ANY WARRANTY; without even the implied warranty of
--     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--     GNU General Public License for more details.
-- 
--     You should have received a copy of the GNU General Public License
--     along with XtremWeb-HEP.  If not, see <http://www.gnu.org/licenses/>.
-- 
--
-- Since : 8.3.0
--
-- File    : restarted_last_six_months.sql
-- Purpose : this file contains the needed SQL commands to 
--           retrieve restarted jobs per week  from DB for the last 6 months
-- Usage   : mysql < restarted_last_six_months.sql
--


select laststartdate,count(*)
       from (
         (select date_format(laststartdate,"%Y/%m") as laststartdate,count(*) as restarteds from tasks 
         where not isnull(laststartdate)
 	 		and not isnull(startdate)
            and laststartdate > date_sub(now(), interval 6 month) group by laststartdate)
	     union all
         (select date_format(laststartdate,"%Y/%m") as laststartdate,count(*) as restarteds from tasks_history
         where not isnull(laststartdate)
 	 		and not isnull(startdate)
            and laststartdate > date_sub(now(), interval 6 month) group by laststartdate)
 	  ) as t 
 	  group by laststartdate order by laststartdate;
