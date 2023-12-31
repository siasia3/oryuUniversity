package kr.or.ddit.schedule.vo.adapter;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

public abstract class FullCalendarEvent<T> {
	
	private T adaptee;
	public FullCalendarEvent(T adaptee) {
		super();
		this.adaptee = adaptee;
	}
	
	public abstract String getId();
	public abstract String getTitle();
	@JsonFormat(shape = Shape.STRING)
	public abstract LocalDateTime getStart();
	@JsonFormat(shape = Shape.STRING)
	public abstract LocalDateTime getEnd();
	
//	public boolean isAllDay() {
//		return true;
//	}
	
	public T getData() {
		return adaptee;
	}
	
	public Map<String, Object> getExtendedProps() {
		return Collections.singletonMap("data", getData());
	}
}
